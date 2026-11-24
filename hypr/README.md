# Hyprland (Omarchy)

個人設定を管理する。`install.sh` が `~/.config/hypr/` にリンクする。

## 画面ごとのワークスペース

各画面に5個ずつ固定し、バーはその画面の `1〜5` だけを表示する。
選択中も番号を残し、色と下線で現在位置を示す。空きの番号は薄く表示する。
バーの番号をクリックすると、その画面だけが切り替わる。

キーボード操作はフォーカス中の画面が対象。
`input.lua` はクリックでフォーカスを移す設定なので、別画面を操作する場合は先にその画面をクリックする。
`Ctrl+Alt+Tab` でも次の画面へフォーカスを移せる。

| キー | 動作 |
|---|---|
| Super+1〜5 | この画面のワークスペース1〜5へ切り替え |
| Super+Shift+1〜5 | 選択中のウィンドウをこの画面の1〜5へ移動し、移動先を表示 |
| Super+Shift+Alt+1〜5 | ウィンドウだけを移動し、表示は維持 |
| Super+Tab / Super+Shift+Tab | この画面内で次 / 前へ循環 |
| Super+Ctrl+Tab | この画面で直前に使ったワークスペースへ戻る |
| Super+マウスホイール | この画面内でワークスペースを循環 |

従来の全画面共通の番号操作を置き換える。Super+6〜0（Shift、Shift+Alt付きも含む）の
ワークスペース割り当ては解除している。

`monitors.lua` の永続ワークスペースを画面ごとに内部ID順で並べ、キーには `r~1` などの
モニター内番号、循環には `m+1` / `m-1` を使う。
バーは [yoooz.workspaces](../omarchy/plugins/yoooz.workspaces/) が同じ順序で表示する。

| 画面 | バーの番号 | Hyprlandの内部ID |
|---|---|---|
| 左のLG（DP-1） | 1〜5 | 1, 4, 7, 10, 13 |
| 中央のXEC（DP-2） | 1〜5 | 2, 5, 8, 11, 14 |
| 上のI-O DATA（DP-3） | 1〜5 | 3, 6, 9, 12, 15 |

既存の内部ID 1/2/3と `autostart.lua` のアプリ配置を保っている。
モニターの増減・接続名変更時や、ワークスペース自体を別画面へ移した場合は割り当てを見直す。
切断した画面のワークスペースが別画面へ退避すると、表示数やモニター内番号も変わる。

仕様: [Hyprlandのワークスペースルール](https://wiki.hypr.land/configuring/core/rules/workspace-rules/)、
[ワークスペースセレクター](https://wiki.hypr.land/0.56.0/configuring/basics/dispatchers/#workspace-selectors)。

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
Super+矢印など、その他のウィンドウ操作はOmarchy標準のまま。

アプリ判定にはOmarchyの `terminal`、`chromium-based-browser`、
`firefox-based-browser` タグを使う。Chromeを含む対応ブラウザーで適用される。
Omarchyのタグ定義が変わったり、独自app-idの端末を追加した場合は判定を見直す。

## 反映と確認

```bash
luac -p ~/dotfiles/hypr/bindings.lua
luac -p ~/dotfiles/hypr/monitors.lua
hyprctl reload
hyprctl configerrors
```

ChromeでSuper+Tを使って検証用タブを開き、Super+Wでそのタブだけが閉じることを確認する。
入力欄では全選択・コピー・貼り付け・元に戻すを確認する。
端末では既存のCtrl操作と全画面操作を確認する。
各画面で1〜5の切り替え・端から端への循環を試し、他画面の表示が変わらないことを確認する。
