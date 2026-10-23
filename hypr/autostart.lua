-- Initial placement for the applications opened at login.
-- These rules also apply to new windows opened later; windows can still be moved.
o.window("^com\\.mitchellh\\.ghostty$", { workspace = "2 silent" })
o.window("^google-chrome$", { workspace = "1 silent" })
o.window("^chatgpt$", { workspace = "3 silent" })

o.launch_on_start("ghostty")
o.launch_on_start("google-chrome-stable")
o.launch_on_start("chatgpt")
