# dotfiles
My dotfiles files. 
Include nvim, zsh and herdr.

個人用のエージェント設定は [ai/](ai/README.md)、自作スキルは [skills/](skills/README.md) で管理する。

Ghostty は macOS では `ghostty/config`、Omarchy では `ghostty/config.omarchy` を使用する。
Omarchy 用設定は `~/.local/state/omarchy/current/theme/ghostty.conf` を読み込み、テーマ変更に追従する。

Omarchy のモニター・入力・自動起動設定は `hypr/`、バーと待機時間は `omarchy/shell.json` で管理する。
追加プラグインの一覧と復元方法は [omarchy/](omarchy/README.md) を参照。
ログイン時に Chrome をワークスペース1、Ghostty を2、ChatGPT を3で起動する。
スクリーンセーバーは無操作10分、自動ロックは15分で有効になる。

## How to run
```
$ git clone https://github.com/yoooz/dotfiles.git
$ [dotfile's path]/install.sh
```
