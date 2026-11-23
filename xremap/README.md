# xremap (Omarchy / Hyprland)

GUI 全般の移動・削除を Emacs 風にする。macOS には適用しない。
端末・IDE・Emacs・Vim/Neovim GUI は `config.yml` の `application.not` で除外する。
実機で確認したクラスは Chrome が `google-chrome`、ChatGPT が `chatgpt`、Ghostty が `com.mitchellh.ghostty`。
ほかの除外条件は一般的なクラス名で、新しいアプリを導入したら実クラスを確認する。

## キー操作

| キー | 動作 |
|---|---|
| Ctrl+f / b / p / n | 右 / 左 / 上 / 下 |
| Ctrl+a / e | Home / End |
| Ctrl+h / d | Backspace / Delete |
| Ctrl+k | Shift+End → Backspace（行末まで削除） |
| Ctrl+q | 次のキー操作だけ変換せず送る |

`Ctrl+q → Ctrl+f` で検索、`Ctrl+q → Ctrl+a` で全選択。その次から変換が復帰する。
左右どちらの Ctrl も対象。`exact_match: true` により、Ctrl+Shift+f など追加修飾キーを含む操作は変更しない。
CapsLock や修飾キー単体も変更しない。

入力欄へのフォーカスは判別しないので、対象アプリでは入力欄以外でも変換される。
Home/End や折り返し行の扱いは各アプリに従う。
Ctrl+k は選択と Backspace の組み合わせで、kill ring・マーク・単語移動・行末での改行削除は実装しない。
**すでに行末にいる場合は選択範囲が空になり、Backspace が直前の文字（空行では改行）を消す場合がある。**
Emacs の kill-line の完全な再現ではない。既存の選択範囲がある場合もアプリの選択動作に従う。

## 導入

専用スクリプトは不要。通常の `install.sh` が Linux / Omarchy で
`config.yml` を `~/.config/xremap/config.yml` にリンクする。

初回だけ、[公式 v0.15.18 リリース](https://github.com/xremap/xremap/releases/tag/v0.15.18) の
`xremap-linux-x86_64-hypr.zip`（この端末用）を展開し、実行ファイルを `~/.local/bin/xremap` に配置する。
この端末には配置済み。別アーキテクチャでは対応する Hyprland 版を選ぶ。

入力権限も初回だけ設定する。以下は **ユーザーの全プロセスに入力デバイスの読み取りと仮想入力の生成を許可する** 変更になる。
端末で次を実行し、再起動してグループ・モジュール・デバイス権限を反映する。

```bash
sudo usermod -aG input "$(id -un)"
printf 'uinput\n' | sudo tee /etc/modules-load.d/xremap.conf
printf '%s\n' 'KERNEL=="uinput", GROUP="input", MODE:="0660", OPTIONS+="static_node=uinput"' \
  | sudo tee /etc/udev/rules.d/99-xremap.rules
```

Arch の既存の `/dev/input/event*`（`root:input`, `0660`）を利用する。

## 起動・設定変更

`hypr/autostart.lua` からログイン時に xremap を直接起動する（`o.launch_on_start` が `uwsm-app` を使う）。
設定変更とキーボード接続を `--watch=config,device` で監視し、`--no-window-logging` でタイトル・クラスのログ出力を抑える。
設定の symlink は `readlink -f` で解決する。エディターがファイルを置き換えて保存しても、dotfiles 側のディレクトリで変更を検出できるようにするため。

手動起動は、停止中か確認してから Hyprland セッション内の一般ユーザーで実行する。

```bash
~/.local/bin/xremap --watch=config,device --no-window-logging \
  "$(readlink -f ~/.config/xremap/config.yml)"
```

起動確認とクラス確認（タイトルは出力しない）:

```bash
pgrep -a -u "$(id -u)" -x xremap
hyprctl -j clients | jq '[.[] | {class, initialClass}] | unique'
```

新しい端末・IDE やクラス変更があれば `application.not` に追加する。
ブラウザー内の IDE や端末はブラウザーと同じクラスなので、この除外では判別できない。

## 停止・自動起動解除

今すぐ停止すると元のキー操作に戻る（除外されている端末から実行できる）。自動再起動はしない。

```bash
pkill -TERM -u "$(id -u)" -x xremap
```

次のログインでも起動しないようにするには、`hypr/autostart.lua` の xremap の `o.launch_on_start(...)` を削除またはコメントアウトする。
その後 `hyprctl reload` と `hyprctl configerrors` で確認する。リロードだけでは実行中のプロセスは停止しない。

入力権限も撤去する場合は、xremap を停止し、ほかの入力ツールが `input` グループを必要としていないことを確認してから実行する。

```bash
sudo gpasswd -d "$(id -un)" input
sudo rm -f /etc/modules-load.d/xremap.conf /etc/udev/rules.d/99-xremap.rules
sudo udevadm control --reload-rules
```

再起動して既存プロセスのグループとデバイス権限を更新する。共有中の可能性がある uinput モジュールを実行中にアンロードしない。

## 検証

```bash
bash -n ~/dotfiles/install.sh
~/.local/bin/xremap --validate-config ~/.config/xremap/config.yml
hyprctl reload
hyprctl configerrors
```

Chrome とチャット入力欄の未送信テキストで以下を確認する。受け入れ条件には実キーでの操作も含む。

- 移動・行頭/行末・削除、長押し、日本語入力の変換中と確定後の操作。
- Ctrl+q → Ctrl+f で検索、Ctrl+q → Ctrl+a で全選択、その次の操作では変換が復帰する。
- Ghostty と使用する IDE では元のショートカットが維持される。
- 再ログイン後に一般ユーザーの xremap が一つ起動する。
- キーボードを再接続しても変換が継続する。
- 停止後は元のキー操作に戻る。

参考: [固定版リリース](https://github.com/xremap/xremap/releases/tag/v0.15.18)、
[設定仕様](https://github.com/xremap/xremap/blob/v0.15.18/README.md)、
[一般ユーザーでの実行](https://github.com/xremap/xremap/blob/v0.15.18/doc/running_without_sudo.md)。
