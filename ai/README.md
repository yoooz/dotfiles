# 個人用エージェント設定

Claude Code と Codex で使う個人用の指示・設定を管理する。

```text
ai/
├── AGENTS.md          # 両エージェント共通の個人用指示
├── personas/          # 会話スタイル・キャラ設定
└── claude/
    ├── settings.json  # Claude Code 固有の設定
    └── scripts/       # 通知・ステータスライン
```

リポジトリ直下で `./install.sh` を実行すると、以下の symlink を作成する。

| 管理元 | 配置先 |
|---|---|
| `ai/AGENTS.md` | `~/.claude/CLAUDE.md` |
| `ai/AGENTS.md` | `~/.codex/AGENTS.md` |
| `ai/claude/settings.json` | `~/.claude/settings.json` |
| `ai/claude/scripts/` | `~/.claude/scripts/` |

`CODEX_HOME` が設定されている場合、Codex の配置先は `$CODEX_HOME/AGENTS.md` になる。共通指示は `ai/AGENTS.md` を編集し、キャラ設定の参照は symlink を解決した実体の位置を基準にする。

ルートの `AGENTS.md` はこの dotfiles リポジトリでの作業用、`ai/AGENTS.md` は各プロジェクトで使う個人用の指示。自作スキルはルートの `skills/` で管理する。

Codex から Claude Code に設計やコードを相談するには、[`ask-claude`](../skills/ask-claude/SKILL.md) を使う。
`./install.sh` で Codex 用のスキルを配置できる。導入・使用方法は [`skills/README.md`](../skills/README.md) を参照。
