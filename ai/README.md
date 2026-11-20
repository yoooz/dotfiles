# 個人用エージェント設定

Claude Code、Codex、Antigravity CLI で使う個人用の指示・設定を管理する。

```text
ai/
├── AGENTS.md          # 3 エージェント共通の個人用指示
├── personas/          # 会話スタイル・キャラ設定
├── claude/
│   ├── settings.json  # Claude Code 固有の設定
│   └── scripts/       # 通知・ステータスライン
├── codex/
│   └── config.toml    # Codex 固有の設定
└── antigravity/
    ├── settings.json # CLI にマージする設定
    ├── install.sh    # Antigravity 設定だけを適用
    └── statusline.py # モデル・ディレクトリ・ブランチ・context・利用枠
```

リポジトリ直下で `./install.sh` を実行すると、以下の symlink を作成する。

| 管理元 | 配置先 |
|---|---|
| `ai/AGENTS.md` | `~/.claude/CLAUDE.md` |
| `ai/AGENTS.md` | `~/.codex/AGENTS.md` |
| `ai/AGENTS.md` | `~/.gemini/AGENTS.md` |
| `ai/claude/settings.json` | `~/.claude/settings.json` |
| `ai/claude/scripts/` | `~/.claude/scripts/` |
| `ai/codex/config.toml` | `~/.codex/config.toml` |
| `ai/antigravity/statusline.py` | `~/.gemini/antigravity-cli/statusline.py` |

`CODEX_HOME` が設定されている場合、Codex の配置先は `$CODEX_HOME/` 配下になる。共通指示は `ai/AGENTS.md` を編集し、キャラ設定の参照は symlink を解決した実体の位置を基準にする。
共通指示へのリンクは絶対パスで作成する。リポジトリを移動した場合は、`./install.sh` を再実行する。

Antigravity の `settings.json` は CLI が `trustedWorkspaces` なども保存するため、
symlink にせず `ai/antigravity/settings.json` のトップレベル項目だけをマージする。
変更前のファイルは同じディレクトリの `settings.json.bak` に保存する（次回適用で更新）。
Antigravity だけ設定する場合は、リポジトリ直下で以下を実行する。
共通指示のリンク、CLI 設定、相談用の `ask-codex` / `ask-claude` を配置する。Python 3 が必要。

```bash
bash ai/antigravity/install.sh
```

ステータスラインは Claude Code に近い 1 行表示。`ctx` はコンテキスト使用率、
利用枠の `残` は残量、`→` はローカル時刻のリセット予定を表す。
利用枠が未取得・無効・リセット時刻を過ぎている場合、その枠は表示しない。
色は使用率 70% 未満が緑、70% 以上が黄、90% 以上が赤。
表示を変更するには `ai/antigravity/statusline.py` を編集する。
設定の反映は `agy` を再起動するか、起動中の CLI で以下を実行する。

```text
/statusline ~/.gemini/antigravity-cli/statusline.py
```

仕様: [Antigravity CLI のステータスライン](https://antigravity.google/docs/cli/statusline/)

Codex の `config.toml` には、Codex CLI や ChatGPT デスクトップアプリが自動で書き込む項目
（`projects` の信頼リスト、`marketplaces`、`plugins`、`mcp_servers` の環境変数など）が混在する。
CLI は symlink をたどって実体を直接編集する。
`projects` は端末ごとの信頼設定なので、Git の clean filter で `git add` 時に除外する。
手元の `config.toml` には残り、他の項目は通常どおり Git で管理する。
フィルターには Python 3.11 以降が必要。`./install.sh` が clone ごとに設定する。
設定だけを適用する場合は、リポジトリ直下で以下を実行する。

```bash
git config --local filter.codex-config.clean 'python3 ai/codex/filter-config.py'
git config --local filter.codex-config.required true
```

新しい clone では、コミットする前に必ずフィルターを設定すること。
Git のローカル設定は clone で引き継がれず、未設定だと除外されない。
`git restore` やブランチ切り替えでファイルが書き戻されると、手元の `projects` も失われる。
その場合は Codex でプロジェクトを信頼し直す。過去のコミットにある `projects` は削除しない。

自分で編集したい項目は `model`、`sandbox_workspace_write.writable_roots` など先頭付近にまとめてあり、
`projects` 以外の自動書き込み分はレビューして必要なものだけコミットする。
自分で書く項目のパスは `~` で始める。Codex は `~` を展開するが、`$HOME` などの環境変数は展開しない。
自動書き込み分の絶対パスは書き換えても次回の自動書き込みで戻るため、そのままにする。

ルートの `AGENTS.md` はこの dotfiles リポジトリでの作業用、`ai/AGENTS.md` は各プロジェクトで使う個人用の指示。自作スキルはルートの `skills/` で管理する。

Codex から Claude Code に設計やコードを相談するには、[`ask-claude`](../skills/ask-claude/SKILL.md) を使う。
Antigravity CLI からは `ask-codex` と `ask-claude` の両方を使える。
`./install.sh` で Codex 用のスキルを配置できる。導入・使用方法は [`skills/README.md`](../skills/README.md) を参照。
