# Agent Skills

自作の agent skill を dotfiles で管理・配布するためのディレクトリ。

skill は出自によって管理方法を分ける：

| 出自 | 本体の場所 | dotfilesでの扱い |
|---|---|---|
| 自作カスタム | `skills/<name>/`（このディレクトリ） | symlink 経由で有効化 |
| 外部 (`npx skills add`) | `~/.claude/skills/<name>/`（CLI管理） | インストールコマンドを下に記録 |
| 公式 (`~/.agents/skills/`) | Anthropic管理 | 有効化リストを下に記録 |

## 自作カスタムskill

`skills/<skill-name>/SKILL.md` を作って `./install.sh` を実行すれば、`~/.claude/skills/<skill-name>` に symlink が貼られる。
Codex 用の `ask-claude` は `~/.agents/skills/ask-claude` に配置する。

`install.sh` は `skills/*/` をループするので、Claude Code 用の skill 追加ごとにスクリプトを書き換える必要はない。

skill名は外部skillや公式skillと衝突させないこと（自作のsymlinkで上書きされる）。

### GitHub からインストール

dotfiles の symlink を使わない環境では、GitHub に反映済みの skill を `gh skill install` で導入できる。

```bash
gh skill install yoooz/dotfiles craft-review --agent claude-code --scope user
# Codex から Claude に相談する skill
gh skill install yoooz/dotfiles ask-claude --agent codex --scope user
# Claude から Codex に相談する skill
gh skill install yoooz/dotfiles ask-codex --agent claude-code --scope user
```

構成の検証: repository root で `gh skill publish --dry-run` を実行する。

### Codex から Claude に相談する

`ask-claude` を導入すると、Codex に「Claude にこの設計を相談して」または
`$ask-claude この変更をレビューして` と依頼できる。
明示的な依頼がなくても、重要な設計判断や複雑な実装上の意思決定では Codex が能動的に相談する。
Claude は案の前提・反例・代替案を批判的に検討し、Codex が根拠を確認して作業を進める。
自明な修正や整形では自動相談しない。

前提はローカルの Claude Code CLI とログイン済みの認証。呼び出しスクリプトは
Claude Code 2.1.270 で利用できるオプションを使う。モデルは Claude 側の設定を引き継ぐ。
相談は毎回独立し、会話履歴は保存しない。具体的な動作と呼び出し方法は
[`ask-claude/SKILL.md`](ask-claude/SKILL.md) を参照。

Codex は `~/.agents/skills` の symlink を読み込む。追加後にスキルが表示されなければ
Codex を再起動する。配置の仕様は [OpenAI のスキルドキュメント](https://learn.chatgpt.com/docs/build-skills)、
呼び出しオプションは [Claude Code CLI reference](https://code.claude.com/docs/en/cli-reference) を参照。

### Claude から Codex に相談する

`ask-codex` を導入すると、Claude Code に「Codex にこの設計を相談して」または
`/ask-codex この変更をレビューして` と依頼できる。
明示的な依頼がなくても、重要な設計判断や複雑な実装上の意思決定では Claude が能動的に相談する。
Codex は案の前提・反例・代替案を批判的に検討し、Claude が根拠を確認して作業を進める。
自明な修正や整形では自動相談しない。

前提はローカルの Codex CLI とログイン済みの認証。呼び出しスクリプトは
codex-cli 0.153.4 で利用できるオプションを使う。モデルと reasoning effort は
`~/.codex/config.toml` を引き継ぐ。相談は毎回独立し、セッションは保存しない。
具体的な動作と呼び出し方法は [`ask-codex/SKILL.md`](ask-codex/SKILL.md) を参照。

`ask-claude` と `ask-codex` は互いに再帰ガードを持つ。各スクリプトは起動時に
`ASK_CLAUDE=1` / `ASK_CODEX=1` を export し、相手側のスクリプトはそのマーカーや
`CLAUDECODE` / `CODEX_SESSION_ID` を見て、Claude と Codex が相談し合うループを拒否する。

## 外部skill（`npx skills add` でインストール）

再構築時は以下を手動で実行する。`-g` で user スコープ、`-y` で確認プロンプトをスキップ。

```bash
npx skills add shibayu36/agent-skills@gws-docs-to-markdown -g -y
```

更新確認: `npx skills check` / 一括更新: `npx skills update`

## 公式skill（Anthropic 提供）

本体は `~/.agents/skills/` 配下、`~/.claude/skills/<name> -> ../../.agents/skills/<name>` の symlink で有効化されている。本体は dotfiles で再現できないので、再構築時は `find-skills` 経由で手動再インストール。

- find-skills
- gws-docs
- gws-drive
- gws-sheets-read
