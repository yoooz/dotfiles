---
name: my-review
description: >
  GitHub PRのURL (例: https://github.com/owner/repo/pull/123) が渡されたら、
  複数の観点ごとにサブエージェントを並列起動して徹底レビューする。
  デフォルト観点はコード簡略化とバグ検出。URLと一緒に自由記述で追加観点を渡せる
  (例: 「パフォーマンス観点も」「セキュリティもチェック」)。
---

# My Review

GitHub PR を複数観点で徹底レビューするスキル。観点ごとにサブエージェントを並列起動し、独立したコンテキストでレビューさせてから指摘を集約する。

## いつ使うか

- ユーザーが GitHub PR URL (`https://github.com/<owner>/<repo>/pull/<n>`) を渡した
- URLと一緒に自由記述の追加観点が含まれている場合は、それを観点に追加する

## 動作フロー

### Step 1: PR情報の取得

```bash
gh pr view <PR_URL> --json title,body,baseRefName,headRefName,files,additions,deletions,author
gh pr diff <PR_URL>
```

- diff が極端に巨大な場合（例: 数千行超）は、`files` をグループ分けして観点ごとに割り当てるかを判断する
- PR の base/head ブランチ名は周辺コード調査のヒントとして sub agent に渡す

### Step 2: 観点リストの確定

**デフォルト観点**:
- `perspectives/simplification.md` — コード簡略化
- `perspectives/bug-detection.md` — バグ混入チェック

**ユーザー指定の追加観点**:
- 自由記述から観点を抽出する（例:「パフォーマンス」「セキュリティ」「ドキュメント」「テスト網羅性」）
- 追加観点には対応する md ファイルが無いので、観点名と着眼点を sub agent prompt にインライン記述する

### Step 3: サブエージェントを並列起動

**重要: 観点ごとの `Agent` ツール呼び出しは、1メッセージ内に複数同時に書いて並列実行する**こと。直列に起動するとレビュー時間が観点数倍になる。

各 sub agent には `subagent_type: general-purpose` を指定し、以下を含むプロンプトを渡す:

````
あなたは GitHub PR を「<観点名>」の観点で徹底レビューします。

# PR情報
- URL: <PR_URL>
- タイトル: <title>
- 著者: <author>
- 変更ファイル数: <N>, 追加 +<A> / 削除 -<D>
- base: <baseRefName> ← head: <headRefName>

# diff
以下のコマンドで diff を取得して読んでください:
gh pr diff <PR_URL>

# レビュー観点
<perspectives/<perspective>.md の内容、または追加観点の説明文>

# 進め方
1. diff全体に目を通す
2. 観点に照らして気になる箇所をピックアップ
3. 必要に応じてリポジトリ内の周辺コードを `Read` / `Grep` / `git grep` で確認
   - 関数の呼び出し元、類似実装、変更前の挙動などを調べて、表層的でない指摘をする
4. false positive を避けるため、指摘の前提条件が崩れる可能性があれば明記

# 出力形式
最後に、以下のJSON形式でだけ findings を返してください (前置きや感想は不要):

```json
{
  "perspective": "<観点名>",
  "findings": [
    {
      "file": "path/to/file.ext",
      "line": 123,
      "severity": "critical | major | minor | nit",
      "title": "短い見出し (1行)",
      "detail": "問題の説明と修正提案。複数行可。"
    }
  ]
}
```

severity の目安:
- critical: バグ・セキュリティ・データ破壊など本番影響が大きいもの
- major: 設計や保守性に大きく影響するが即座にバグにはならないもの
- minor: 改善した方が良いが現状でも動くもの
- nit: 好みレベル
````

### Step 4: 結果のマージと報告

すべての sub agent から JSON を受け取ったら、ユーザーには以下の形式で報告する:

````markdown
# PR レビュー: <PR_URL>

<title> by @<author> (+<additions> / -<deletions>, <N> files)

## サマリ (重要度順)

| # | severity | file:line | title | 観点 |
|---|----------|-----------|-------|------|
| 1 | critical | foo.go:42 | nil pointer の可能性 | バグ検出 |
| 2 | major    | bar.ts:10 | 標準ライブラリで置換可能 | 簡略化 |
| ... |

## 観点ごとの詳細

### コード簡略化
- **bar.ts:10 [major]** 標準ライブラリで置換可能
  > Array.from() の代わりに spread (...) で書ける。
  > Before: ... / After: ...

### バグ検出
- **foo.go:42 [critical]** nil pointer の可能性
  > req.User が nil のときに参照しているので panic する。
  > 修正案: 事前に if req.User == nil { ... } のガードを追加。

### <ユーザー追加観点があれば>
...
````

サマリ表は severity 順 (critical → major → minor → nit) でソート。同 severity 内は file:line 順。

## 注意点とエッジケース

- **並列実行は必須**: 観点ごとに別メッセージで起動すると context window を無駄に消費し、応答時間も観点数倍になる
- **diff が巨大すぎる場合**: 各 sub agent に「ファイル `A.go` と `B.go` のみ」のようにスコープを絞って割り当てる
- **JSON抽出に失敗した sub agent**: 出力をそのまま「観点ごとの詳細」セクションに掲載し、サマリ表からは除外する
- **追加観点に対応する md が無い**: prompt 内に「<観点名>: <着眼点の説明>」をインラインで書く。あとで頻出する観点は `perspectives/` に切り出してこのskillに育てる
- **PR が draft / closed**: `gh pr view` で状態を取り、ユーザーに確認してから進める

## 観点の追加方法

`perspectives/<name>.md` を追加するだけ。`perspectives/` 直下のファイルは「いつ使うかの判断は SKILL.md 側、観点の中身は md 側」という分担で書く。
