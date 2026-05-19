# Agent Skills

Claude Code の agent skill を dotfiles で管理するためのディレクトリ。

skill は出自によって管理方法を分ける：

| 出自 | 本体の場所 | dotfilesでの扱い |
|---|---|---|
| 自作カスタム | `claude/skills/<name>/`（このディレクトリ） | symlink 経由で有効化 |
| 外部 (`npx skills add`) | `~/.claude/skills/<name>/`（CLI管理） | インストールコマンドを下に記録 |
| 公式 (`~/.agents/skills/`) | Anthropic管理 | 有効化リストを下に記録 |

## 自作カスタムskill

`claude/skills/<skill-name>/SKILL.md` を作って `./install.sh` を実行すれば、`~/.claude/skills/<skill-name>` に symlink が貼られる。

`install.sh` は `claude/skills/*/` をループするので、skill追加ごとにスクリプトを書き換える必要はない。

skill名は外部skillや公式skillと衝突させないこと（自作のsymlinkで上書きされる）。

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
