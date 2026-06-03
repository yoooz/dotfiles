#!/usr/bin/env python3
"""fetch_article.py — URL から記事のタイトルと本文テキストを取得する。

要約はしない（要約は呼び出し側の Claude 本体が行う）。決定的な処理だけを担う:
  - HTTP 取得（リダイレクト追従・User-Agent 付き・タイムアウト）
  - 文字コード判定（HTTP ヘッダ → meta タグ → U+FFFD 最小ヒューリスティック）
  - script/style 等の除去と本文抽出（<article>/<main>/<p>）
  - 複数ページ表記の検出（本文が一部でしかない可能性を呼び出し側に伝える）
  - ペイウォール（続きは会員登録が必要 等）の検出

標準ライブラリのみで動く（インストール不要）。

Usage:
    python3 fetch_article.py <URL> [--max-chars N]

終了コード:
    0  本文を取得できた
    2  取得はできたが本文がほとんど抽出できなかった（SPA の可能性 / フォールバック推奨）
    1  HTTP 取得そのものに失敗した
"""

import argparse
import html
import re
import sys
import urllib.request
import urllib.error

USER_AGENT = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36"
)
TIMEOUT = 20

# 本文抽出時、これより短い段落はナビ/UI 部品とみなして捨てる（見出しは別扱い）
MIN_PARAGRAPH_LEN = 16

PAYWALL_MARKERS = [
    "続きを読むには",
    "会員登録",
    "ログインして",
    "この記事は会員限定",
    "有料会員",
    "の登録が必要",
    "purchase to read",
    "subscribe to read",
    "subscribers only",
    "this article is for",
]


def fetch_bytes(url):
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=TIMEOUT) as resp:
        charset = resp.headers.get_content_charset()
        final_url = resp.geturl()
        return resp.read(), charset, final_url


def detect_encoding(raw, header_charset):
    """HTTP ヘッダ → meta タグ → ヒューリスティックの順で文字コードを決める。"""
    if header_charset:
        return header_charset
    # meta charset は ascii 範囲に書かれるので、生バイトを latin-1 で覗いて探す
    head = raw[:4096].decode("latin-1", errors="replace")
    m = re.search(r'charset=["\']?\s*([\w\-]+)', head, re.I)
    if m:
        return m.group(1)
    # 判定不能: 候補でデコードし、置換文字(U+FFFD)が最少のものを採用
    best, best_bad = "utf-8", None
    for enc in ("utf-8", "cp932", "euc-jp", "shift_jis"):
        try:
            bad = raw.decode(enc, errors="replace").count("�")
        except LookupError:
            continue
        if best_bad is None or bad < best_bad:
            best, best_bad = enc, bad
    return best


def decode(raw, enc):
    try:
        return raw.decode(enc, errors="replace")
    except LookupError:
        return raw.decode("utf-8", errors="replace")


def strip_noise(s):
    """本文抽出の邪魔になる要素を丸ごと削る。"""
    s = re.sub(r"(?is)<script.*?</script>", " ", s)
    s = re.sub(r"(?is)<style.*?</style>", " ", s)
    s = re.sub(r"(?is)<noscript.*?</noscript>", " ", s)
    s = re.sub(r"(?is)<template.*?</template>", " ", s)
    s = re.sub(r"(?s)<!--.*?-->", " ", s)
    return s


def extract_title(s):
    m = re.search(
        r'<meta[^>]+property=["\']og:title["\'][^>]+content=["\'](.*?)["\']', s, re.I | re.S
    )
    if m:
        return html.unescape(m.group(1)).strip()
    m = re.search(r"<title[^>]*>(.*?)</title>", s, re.I | re.S)
    if m:
        return html.unescape(re.sub(r"<[^>]+>", "", m.group(1))).strip()
    return "(タイトル不明)"


def tag_text(fragment):
    """HTML 断片からタグを除いたテキストを返す。"""
    t = re.sub(r"(?s)<[^>]+>", "", fragment)
    return html.unescape(t).strip()


def extract_body(s):
    """<article> → <main> → <body> の順に本文領域を絞り、見出しと段落を拾う。"""
    region = None
    for tag in ("article", "main"):
        blocks = re.findall(r"(?is)<%s\b[^>]*>(.*?)</%s>" % (tag, tag), s)
        if blocks:
            region = max(blocks, key=len)  # 最も長いものを本文とみなす
            break
    if region is None:
        m = re.search(r"(?is)<body\b[^>]*>(.*?)</body>", s)
        region = m.group(1) if m else s

    parts = []
    # 見出しと段落を出現順に拾う
    for m in re.finditer(r"(?is)<(h[1-3]|p)\b[^>]*>(.*?)</\1>", region):
        kind, frag = m.group(1).lower(), m.group(2)
        text = tag_text(frag)
        if not text:
            continue
        if kind.startswith("h"):
            parts.append("\n## " + text)
        elif len(text) >= MIN_PARAGRAPH_LEN:
            parts.append(text)
    return "\n\n".join(parts).strip()


def detect_pages(s, title):
    """「N/M ページ」表記や rel=next を検出して、本文が一部である可能性を返す。"""
    m = re.search(r"(\d+)\s*/\s*(\d+)\s*ページ", title + " " + s[:6000])
    if m and int(m.group(2)) > 1:
        return "%s/%s ページ表記を検出（本文は1ページ目のみ。全文は続きページの取得が必要）" % (
            m.group(1),
            m.group(2),
        )
    if re.search(r'(?i)<link[^>]+rel=["\']next["\']', s):
        return "rel=next を検出（続きのページがある可能性）"
    return None


def detect_paywall(s, body):
    haystack = (body[-1500:] + " " + s[-4000:]).lower()
    for marker in PAYWALL_MARKERS:
        if marker.lower() in haystack:
            return '"%s" を検出（本文が途中で切れている可能性）' % marker
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("url")
    ap.add_argument("--max-chars", type=int, default=0, help="本文をこの文字数で切り詰める（0=無制限）")
    args = ap.parse_args()

    try:
        raw, header_charset, final_url = fetch_bytes(args.url)
    except (urllib.error.URLError, urllib.error.HTTPError, ValueError, OSError) as e:
        print("ERROR: 取得に失敗しました: %s" % e, file=sys.stderr)
        return 1

    enc = detect_encoding(raw, header_charset)
    s = decode(raw, enc)
    s = strip_noise(s)

    title = extract_title(s)
    body = extract_body(s)
    page_note = detect_pages(s, title)
    paywall_note = detect_paywall(s, body)

    truncated = False
    if args.max_chars and len(body) > args.max_chars:
        body = body[: args.max_chars]
        truncated = True

    print("URL: %s" % final_url)
    print("TITLE: %s" % title)
    print("ENCODING: %s" % enc)
    if page_note:
        print("PAGES: %s" % page_note)
    if paywall_note:
        print("PAYWALL: %s" % paywall_note)
    print("CHARS: %d%s" % (len(body), "（切り詰め済み）" if truncated else ""))
    print("----- BODY -----")
    print(body)

    # 本文がほとんど取れていなければフォールバックを促す
    if len(body) < 200:
        print(
            "WARNING: 本文がほとんど抽出できませんでした（JS描画のSPA等の可能性）。"
            "WebFetch での全文抽出フォールバックを検討してください。",
            file=sys.stderr,
        )
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
