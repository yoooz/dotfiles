# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 概要

Neovim、Zsh、Tmux などの開発ツール設定を管理する個人用 dotfiles リポジトリ（macOS 向け）。

## インストール

```bash
git clone https://github.com/yooz-o/dotfiles.git
./install.sh
```

install.sh は以下のシンボリックリンクを作成する：
- `zshrc` → `~/.zshrc`
- `tmux.conf` → `~/.tmux.conf`
- `nvim/` → `~/.config/nvim/`
- `claude/CLAUDE.md` → `~/.claude/CLAUDE.md`
- `claude/settings.json` → `~/.claude/settings.json`

## アーキテクチャ

### Neovim (`nvim/`)

LazyVim をプラグインフレームワークとして使用。

```
nvim/
├── init.lua                    # エントリーポイント
└── lua/
    ├── config/
    │   ├── lazy.lua            # LazyVim ブートストラップ
    │   ├── keymaps.lua         # カスタムキーマップ
    │   ├── options.lua         # エディタオプション
    │   └── autocmds.lua        # 自動コマンド
    └── plugins/                # プラグインスペック（自動読込）
        ├── test.lua            # Neotest 設定（Go + gotestsum）
        ├── dap.lua             # デバッグ設定（Delve）
        ├── lsp-override.lua    # LSP 調整
        └── ...
```

新しいプラグインを追加するには、`nvim/lua/plugins/` にプラグインスペックを返す `.lua` ファイルを作成する。

### Zsh (`zshrc`)

主要機能：
- `ghq` + `fzf` によるリポジトリ管理（エイリアス: `gf`）
- Git worktree ヘルパー: `gwc <branch>`（作成して移動）、`gwr`（fzf で選択して削除）
- 履歴検索: `Ctrl+R`（fzf ベース）
- ツール統合: `pyenv`, `rbenv`, `volta`, `direnv`

### Claude Code (`claude/`)

- `CLAUDE.md` → グローバル指示（`~/.claude/CLAUDE.md` にリンク）
- `settings.json` → Claude Code の権限と MCP 設定
- `commands/` → カスタムスラッシュコマンド
- `scripts/` → ステータスライン用スクリプト

## 依存関係管理

- **Homebrew**: `Brewfile` に brew パッケージ、cask、VSCode 拡張を記載
- **LSP サーバー**: `tools.md` に記載（gopls, pyls, typescript-language-server）

## よく使うコマンド

```bash
# Homebrew 依存関係のインストール
brew bundle --file=Brewfile

# zsh 設定の再読込
source ~/.zshrc

# Neovim ヘルスチェック
nvim --headless "+checkhealth" "+qa"
```
