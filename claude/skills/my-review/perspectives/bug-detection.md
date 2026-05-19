# 観点: バグ混入チェック

このPRで新たなバグが混入していないか、または既存のバグが顕在化しないかを判断する。
表面的な「動きそう」ではなく、エッジケース・並行性・退行 (regression) を意識する。

## チェック項目

### 境界条件・null/undefined

- 空配列・空スライス・空マップに対する操作
- ポインタ / null / undefined / nil の参照 (特に `?.` を使っていない箇所)
- off-by-one (`i <= len` vs `i < len`、`start <= end` vs `start < end`)
- 整数オーバーフロー、ゼロ除算
- 浮動小数点の等価比較

### 並行・非同期

- データ競合 (排他制御漏れ、同じ変数を複数のgoroutineやasync taskで更新)
- async/await の `await` 漏れ、Promise が dangling
- goroutine リーク、context のキャンセル伝播漏れ
- イベントハンドラ / リスナーの解除漏れ (memory leak)
- 競合状態 (TOCTOU: Time-of-check to time-of-use)

### エラーハンドリング

- 戻り値の `error` を捨てている、`_ = ...` で握り潰している
- catch しているがログ出力だけで処理が継続して、後段で別の例外が出る
- `panic` / `unwrap` / `!` (TS non-null assertion) の濫用
- エラー時にリソース (file, lock, connection) が解放されない
- リトライ無限ループ

### 状態管理・副作用

- 不変であるべきデータの mutation (参照渡しでの破壊的変更)
- 同じ意味の値を複数の場所に保持して片方しか更新しない
- 副作用のある関数が複数回呼ばれる (べき等性が無い処理)
- グローバル変数 / シングルトンへの隠れた書き込み

### セキュリティ的バグ

- SQL / NoSQL インジェクション
- XSS (innerHTML, dangerouslySetInnerHTML, template経由のエスケープ漏れ)
- コマンドインジェクション (shell=True, eval, exec)
- パスインジェクション、SSRF、open redirect
- 認可チェック漏れ (認証だけして権限を見ていない)
- 秘密情報のログ出力、エラーメッセージへの含有

### 退行 (regression)

- **既存テストが書き換えられていないか**: テストの assert が緩んでいたら理由を確認
- **diff範囲外の caller への影響**: 変更された関数のシグネチャ / 戻り値 / throw する例外が変わっていないか
  - `git grep` でその関数の呼び出し元を全て調べる
- **互換性破壊**: 公開API・DB schema・設定ファイル・環境変数の変更

### 言語固有の罠

- **Go**: ループ変数キャプチャ (1.22未満)、`defer` のクロージャキャプチャ、interface nil 比較
- **TypeScript**: `any` への暗黙キャスト、`==` vs `===`、配列メソッドの破壊性 (`sort`, `reverse`)、`this` の bind
- **Python**: ミュータブルなデフォルト引数、late binding closure、`is` vs `==`
- **Ruby**: `nil` への safe navigation 漏れ、`||=` の意外な挙動

## 判断基準

- **特定の入力で確実にバグになる** → critical
- **特定条件で稀に発生 / データ損失リスク** → critical or major
- **動作はするが将来の改修で踏みやすい罠** → minor
- false positive を避けるため、**前提条件が崩れる可能性**があれば必ず明記

## 指摘の書き方

各 finding には以下を含める:

- **どんな入力 / 状況でバグになるか**: 具体例を1ケース提示 (再現手順または入力例)
- **修正方針**: 1行で
- **前提条件 / false positive の可能性**: ある場合のみ明記

例:
```
foo.go:42 [critical] nil pointer dereference
- 入力例: req.User が nil の場合 (例: 未認証リクエスト)
- 該当行: user.ID を直接参照
- 修正案: 直前で if req.User == nil { return ErrUnauth } のガード追加
- 前提: ミドルウェアで必ず User が設定される保証があるなら false positive
```
