# 個人用エージェント設定

Claude Code と Codex で使う個人用の指示・設定を管理する。

```text
ai/
├── AGENTS.md          # 両エージェント共通の個人用指示
├── personas/          # 会話スタイル・キャラ設定
├── claude/
│   ├── settings.json  # Claude Code 固有の設定
│   └── scripts/       # 通知・ステータスライン
└── codex/
    └── config.toml    # Codex 固有の設定
```

リポジトリ直下で `./install.sh` を実行すると、以下の symlink を作成する。

| 管理元 | 配置先 |
|---|---|
| `ai/AGENTS.md` | `~/.claude/CLAUDE.md` |
| `ai/AGENTS.md` | `~/.codex/AGENTS.md` |
| `ai/claude/settings.json` | `~/.claude/settings.json` |
| `ai/claude/scripts/` | `~/.claude/scripts/` |
| `ai/codex/config.toml` | `~/.codex/config.toml` |

`CODEX_HOME` が設定されている場合、Codex の配置先は `$CODEX_HOME/` 配下になる。共通指示は `ai/AGENTS.md` を編集し、キャラ設定の参照は symlink を解決した実体の位置を基準にする。

Codex の `config.toml` には、Codex CLI や ChatGPT デスクトップアプリが自動で書き込む項目
（`projects` の信頼リスト、`marketplaces`、`plugins`、`mcp_servers` の環境変数など）が混在する。
CLI は symlink をたどって実体を直接編集するため、リポジトリ側に差分として現れる。
自分で編集したい項目は `model`、`sandbox_workspace_write.writable_roots` など先頭付近にまとめてあり、
自動書き込み分はレビューして必要なものだけコミットする。
自分で書く項目のパスは `~` で始める。Codex は `~` を展開するが、`$HOME` などの環境変数は展開しない。
自動書き込み分の絶対パスは書き換えても次回の自動書き込みで戻るため、そのままにする。

ルートの `AGENTS.md` はこの dotfiles リポジトリでの作業用、`ai/AGENTS.md` は各プロジェクトで使う個人用の指示。自作スキルはルートの `skills/` で管理する。

Codex から Claude Code に設計やコードを相談するには、[`ask-claude`](../skills/ask-claude/SKILL.md) を使う。
`./install.sh` で Codex 用のスキルを配置できる。導入・使用方法は [`skills/README.md`](../skills/README.md) を参照。
