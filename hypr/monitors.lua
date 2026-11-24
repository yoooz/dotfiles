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

-- Five persistent workspaces per monitor. Interleaving the internal IDs keeps
-- existing workspaces 1/2/3 (and application placement rules) on their screens.
-- The bar and keyboard shortcuts use each monitor's local order, 1 through 5.
local workspace_monitors = { "DP-1", "DP-2", "DP-3" }
for monitor_index, monitor in ipairs(workspace_monitors) do
  for slot = 1, 5 do
    local workspace = monitor_index + (slot - 1) * #workspace_monitors
    hl.workspace_rule({
      workspace = tostring(workspace),
      monitor = monitor,
      default = slot == 1,
      persistent = true,
    })
  end
end
