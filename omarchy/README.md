# Omarchy

- `shell.json`: バーの配置、プラグイン設定、スクリーンセーバー・ロック時間。
- `plugins.tsv`: 追加プラグインの ID と導入元。標準プラグイン本体は Omarchy が管理する。
- `install-plugins.sh`: 一覧にある未導入プラグインだけを公式 CLI で導入する。

## 追加プラグイン

| プラグイン | 用途 |
|---|---|
| Workspace Icons | ワークスペース内のアプリアイコンを表示 |
| omacursor | テーマに合わせたカーソル配色 |
| BattleStation | GPU・CPU・メモリなどを表示 |

## 復元・更新

Omarchy のグラフィカルセッションで `install.sh` を実行して設定をリンクした後、次を実行する。

```bash
bash ~/dotfiles/omarchy/install-plugins.sh
```

未導入分は導入元の最新版を取得する。既存のプラグインやローカル変更には触れない。
バージョン固定ではなく、導入するプラグインの一覧を管理する。

```bash
omarchy plugin list
omarchy plugin update <id>
```

追加・削除時には `plugins.tsv` と `shell.json` の両方を更新する。
プラグインの設定・配置を UI から変えた場合も、リンク先の `shell.json` に保存される。
