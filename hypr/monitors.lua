-- Positions use logical pixels (resolution divided by scale).
hl.env("GDK_SCALE", "2")

-- Fallback for additional displays.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- LG: left of XEC, aligned along the top edge.
hl.monitor({ output = "DP-1", mode = "3840x2160@60", position = "0x1080", scale = 1.5 })

-- XEC: main ultrawide display.
hl.monitor({ output = "DP-2", mode = "3440x1440@60", position = "2560x1080", scale = 1 })

-- I-O DATA: centered above XEC.
hl.monitor({ output = "DP-3", mode = "1920x1080@60", position = "3320x0", scale = 1 })
