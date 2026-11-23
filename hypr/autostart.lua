-- Initial placement for the applications opened at login.
-- These rules also apply to new windows opened later; windows can still be moved.
o.window("^com\\.mitchellh\\.ghostty$", { workspace = "2 silent" })
o.window("^google-chrome$", { workspace = "1 silent" })
o.window("^chatgpt$", { workspace = "3 silent" })

o.launch_on_start("ghostty")
o.launch_on_start("google-chrome-stable")
o.launch_on_start("chatgpt")

-- Per-user input remapping; installation and permissions: xremap/README.md.
o.launch_on_start(
  '"$HOME/.local/bin/xremap" --watch=config,device --no-window-logging '
    .. '"$(readlink -f "$HOME/.config/xremap/config.yml")"'
)
