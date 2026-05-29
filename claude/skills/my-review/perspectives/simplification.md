# 観点: コード簡略化

このPRのコードがもっとシンプルに書けないかを判断する。
「動くけど冗長」「動くけど過剰に抽象化されている」箇所を見つけて、Before/Afterで提示する。

## チェック項目

### 重複・冗長

- 同じロジックが複数箇所に書かれている (DRY違反)
- 既存のユーティリティ関数や言語標準ライブラリで置き換えられる処理
- if/else の分岐が深すぎる (3段以上のネストは要疑)
- 早期 return で平坦化できる構造

### 不要な抽象化

- 一度しか使われないヘルパー関数 / クラス / interface
- 「将来のため」の generics / hook / option フラグ (YAGNI 違反)
- 過剰な設定可能性 (実際は固定値しか渡されていない options)
- ラッパーが薄すぎて元の API を直接呼んだ方が分かりやすいケース

### 命名と構造

- 変数・関数名が冗長 (`getUserInformationByUserId` → `getUser`)
- 引数が多すぎる関数 (4個以上は構造体にまとめる検討)
- ネストが深いオブジェクト / コンテキストオブジェクトで平坦化できるもの

### 言語固有の慣用句

簡略化の余地が出やすい言語別の典型パターン:

- **TypeScript / JavaScript**: `?.` `??` `satisfies` `structuredClone` `Array.from` / spread, `Object.fromEntries`, optional chaining でのガード省略
- **Go**: `range over int` (1.22+), `slices` / `maps` パッケージ, `errors.Is/As`, `cmp.Or`, `min/max`
- **Python**: list/dict comprehensions, `dataclasses` / `attrs`, `pathlib`, walrus operator
- **Ruby**: blocks, `Enumerable` メソッド, safe navigation (`&.`), `then` / `yield_self`
- **Rust**: `?` 演算子, `if let` / `let else`, `matches!`, iterator chains

## 判断基準

- 簡略化したことで**可読性が落ちる**場合は指摘しない（指摘するならその理由も記載）
- 簡略化で**特定のエラーケース処理が失われる**場合は明記
- チーム規約 (lint, formatter) に反する簡略化は避ける

## severity の目安

- **major**: 30行の関数が標準ライブラリ1行で置き換えられる、明らかに重複ロジックがある
- **minor**: 数行のリファクタで読みやすくなる
- **nit**: 好みレベル (変数名、空白など)
- **critical は基本的に出さない** (簡略化観点での critical は通常無い)

## 指摘の書き方

各 finding には以下を含める:

- Before / After のコード断片を併記
- なぜシンプルになるかを1行で説明
- 簡略化で失われる情報 (特定のエラーハンドリング等) があれば明記
