# Hyprland (Omarchy)

個人設定を管理する。`install.sh` が `~/.config/hypr/` にリンクする。

## Superによるアプリ操作

`bindings.lua` は必要なショートカットだけをCtrl相当に変換する。
Ctrlキー自体は変更せず、端末内のCtrl+CやxremapのEmacs風操作と併用する。

| キー | 動作 | 対象 |
|---|---|---|
| Super+C / V / X | コピー / 貼り付け / 切り取り | Omarchy標準 |
| Super+A | Ctrl+A相当（通常は全選択） | 端末以外 |
| Super+F | Ctrl+F相当（通常は検索） | 端末以外 |
| Super+Z / Shift+Z | Ctrl+Z / Ctrl+Shift+Z相当（通常は元に戻す / やり直す） | 端末以外 |
| Super+W | タブを閉じる | ブラウザー |
| Super+T | 新規タブ | ブラウザー |
| Super+Shift+T | 閉じたタブを復元 | ブラウザー |
| Super+L | アドレスバーへ移動 | ブラウザー |
| Super+R | 再読み込み | ブラウザー |

コピー・貼り付け・切り取りはOmarchy標準を使う。
標準設定は、端末でのコピーをCtrl+Insert、貼り付けをShift+Insertとして送る。
各アプリが独自のCtrl操作を定義している場合は、その動作に従う。

従来のSuper+W（ウィンドウを閉じる）、Super+T（フロート切り替え）、
Super+L（ワークスペースのレイアウト切り替え）はブラウザー以外で維持する。
Super+F（全画面）は端末で維持する。ブラウザーの全画面はF11を使う。
Super+数字・矢印など、その他のウィンドウ操作はOmarchy標準のまま。

アプリ判定にはOmarchyの `terminal`、`chromium-based-browser`、
`firefox-based-browser` タグを使う。Chromeを含む対応ブラウザーで適用される。
Omarchyのタグ定義が変わったり、独自app-idの端末を追加した場合は判定を見直す。

## 反映と確認

```bash
luac -p ~/dotfiles/hypr/bindings.lua
hyprctl reload
hyprctl configerrors
```

ChromeでSuper+Tを使って検証用タブを開き、Super+Wでそのタブだけが閉じることを確認する。
入力欄では全選択・コピー・貼り付け・元に戻すを確認する。
端末では既存のCtrl操作と全画面操作を確認する。
