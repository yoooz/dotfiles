# AGENTS.md

macOS 向けの個人用 dotfiles リポジトリ。開発ツールとエージェントの設定を管理する。

このファイルは Codex・Claude Code 共通のリポジトリ指示。ルートの `CLAUDE.md` はこのファイルへのシンボリックリンク。

## 主な構成

| 場所 | 役割 |
|---|---|
| `nvim/` | LazyVim ベースの Neovim 設定 |
| `zshrc` | シェル設定、ツール連携、リポジトリ・worktree 操作 |
| `herdr/` | ペイン・ワークスペース管理。tmux から移行済み |
| `ghostty/` | ターミナルの表示設定・テーマ |
| `claude/` | Claude Code のユーザー共通指示、設定、補助スクリプト |
| `skills/` | 自作 agent skills。管理・導入方法は `skills/README.md` |
| `Brewfile` | Homebrew のパッケージ管理 |
| `install.sh` | 各設定をホームディレクトリ配下へシンボリックリンクする |

## 変更時の方針

- 設定の管理元はこのリポジトリ。個別の挙動やキー割り当ては、変更対象の設定ファイルを参照する。
- 設定の配置を変更したら、`install.sh` のリンク先も合わせる。
- スキルは `skills/<name>/SKILL.md` を入口とし、補助ファイルもそのスキル内に収める。`gh skill install` で個別に導入できる構成を保つ。

## 検証の入口

- インストールスクリプトの構文確認: `bash -n install.sh`
- スキルの形式検証: `gh skill publish --dry-run`
