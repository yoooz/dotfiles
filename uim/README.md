# uim-fep (Omarchy / SSH)

iPadを英語入力に固定し、SSH先の `uim-fep + Mozc` で日本語に変換する。
デスクトップのFcitx5はそのまま使い、同じユーザーのMozcサーバーに接続する。

## 導入

既存の `fcitx5-mozc` に含まれる `/usr/lib/mozc/mozc_server` を使う。
AURの `uim-mozc` は `mozc` パッケージに依存し、既存の `fcitx5-mozc` と競合するため使わない。
uim 2.0.0を端末用の構成で `~/.local/opt/uim` にビルドする。

```bash
omarchy pkg add base-devel meson ninja protobuf ncurses libvterm

uim_workdir="$(mktemp -d)"
gh release download 2.0.0 --repo uim/uim \
  --pattern uim-2.0.0.tar.gz --dir "$uim_workdir"
tar -xzf "$uim_workdir/uim-2.0.0.tar.gz" -C "$uim_workdir"

meson setup "$uim_workdir/build" "$uim_workdir/uim-2.0.0" \
  --prefix="$HOME/.local/opt/uim" --libdir=lib \
  --buildtype=release \
  -Dauto_features=disabled \
  -Dfep=enabled -Dmozc=enabled -Dlibvterm=enabled \
  -Dnotify=false -Dskk=false
meson compile -C "$uim_workdir/build" -j 4
meson install -C "$uim_workdir/build"
```

リポジトリルートの `install.sh` は、Omarchy上で次のリンクを作る。

- `~/.uim` → `uim/config.scm`
- `~/.local/bin/uim-fep` → `uim/uim-fep`

起動スクリプトがライブラリの検索パスを設定し、必要に応じてMozcサーバーを起動する。
uim自体のビルド・更新は `install.sh` では実行しない。

## 使い方

iPad側を英語入力にしてSSH接続し、`uim-fep` を実行する。
起動したシェル内で、エディタやCLIを使う。

- `Ctrl+]`: 日本語入力のオン・オフ
- `ha`: `は`
- `Shift` を押して `HA`: `HA`（Mozcの「シフトキーでの入力切替」が「英数字」の場合）
- `Space`: 変換、`Enter`: 確定
- 未変換文字列がない状態の `Space`: 半角スペース（以下のMozc共通設定）
- `exit`: uim-fep内のシェルを終了

特定のコマンドだけを包む場合は `uim-fep -e <command> [args...]` を使う。
SSHログイン時には自動起動しない。二重起動は起動スクリプトで防ぐ。

## Mozc共通設定

日本語入力中も空白を半角にするため、Mozc設定の「一般」→「スペースの入力」を「半角」にする。
内部の設定項目は `space_character_form = FUNDAMENTAL_HALF_WIDTH`。
未変換文字列があるときのSpaceによる漢字変換は引き続き使える。
GUIのFcitx5とSSHのuim-fepで、同じMozc設定を共有する。
設定画面はホストのGUI端末で `/usr/lib/mozc/mozc_tool --mode=config_dialog` から開ける。
設定はMozcのユーザープロファイルに保存され、生成されたDB自体はGit管理しない。

## 確認・制約

```bash
uim-fep -v
uim-fep -K
```

`-K` は端末から届くキーを表示する。`Ctrl+]` が届くか確認でき、`Ctrl+C` で終了する。
Mozcの起動ログは `${XDG_STATE_HOME:-$HOME/.local/state}/uim/mozc-server.log` に保存する。

uimは手動更新。MozcのIPC仕様やprotobufの共有ライブラリが変わると、
uimの更新・再ビルドが必要になる場合がある。
`mozc_emacs_helper` は使わないため、Mozcサーバー停止後は `uim-fep` を起動し直す。
`pgrep` による起動確認は同一ユーザー・単一のMozcプロファイルを前提とする。

参考: [uim 2.0.0](https://github.com/uim/uim/releases/tag/2.0.0)、
[Mozc連携](https://github.com/uim/uim/blob/2.0.0/mozc/README.md)、
[uim-fepの使い方](https://github.com/uim/uim/blob/2.0.0/fep/README.ja)。
