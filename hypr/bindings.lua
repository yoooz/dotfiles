-- Keep Omarchy's universal SUPER+C/V/X clipboard bindings.
-- Forward selected application shortcuts without changing physical Ctrl keys.
local function has_tag(window, expected)
  for _, tag in ipairs(window and window.tags or {}) do
    if tag:gsub("%*$", "") == expected then
      return true
    end
  end
  return false
end

local function is_browser(window)
  return has_tag(window, "chromium-based-browser")
    or has_tag(window, "firefox-based-browser")
end

local function is_gui(window)
  return window ~= nil and not has_tag(window, "terminal")
end

-- Match Omarchy's clipboard implementation: explicit modifiers reach the
-- focused surface, and separate down/up events avoid stuck synthetic keys.
local function send_shortcut(mods, key)
  hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
  hl.timer(function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
  end, { timeout = 50, type = "oneshot" })
end

local shortcuts = {
  { key = "A", description = "Select all (GUI)", applies = is_gui },
  { key = "Z", description = "Undo (GUI)", applies = is_gui },
  { key = "Z", shift = true, description = "Redo (GUI)", applies = is_gui },
  {
    key = "F", description = "Find (GUI) / full screen (terminal)", applies = is_gui,
    -- Was SUPER+F: full screen in every application.
    fallback = hl.dsp.window.fullscreen({ mode = "fullscreen" }),
  },
  {
    key = "W", description = "Close tab (browser) / close window", applies = is_browser,
    -- Was SUPER+W: close the entire window, including all browser tabs.
    fallback = hl.dsp.window.close(),
  },
  {
    key = "T", description = "New tab (browser) / toggle floating", applies = is_browser,
    -- Was SUPER+T: toggle floating in every application.
    fallback = hl.dsp.window.float({ action = "toggle" }),
  },
  { key = "T", shift = true, description = "Reopen closed tab (browser)", applies = is_browser },
  {
    key = "L", description = "Address bar (browser) / toggle workspace layout", applies = is_browser,
    -- Was SUPER+L: toggle workspace layout in every application.
    fallback = hl.dsp.exec_cmd("omarchy-hyprland-workspace-layout-toggle"),
  },
  { key = "R", description = "Reload (browser)", applies = is_browser },
}

for _, shortcut in ipairs(shortcuts) do
  local super_mods = shortcut.shift and "SUPER SHIFT" or "SUPER"
  local ctrl_mods = shortcut.shift and "CTRL SHIFT" or "CTRL"
  local binding = (shortcut.shift and "SUPER + SHIFT" or "SUPER") .. " + " .. shortcut.key

  hl.unbind(binding)
  o.bind(binding, shortcut.description, function()
    if shortcut.applies(hl.get_active_window()) then
      send_shortcut(ctrl_mods, shortcut.key)
    elseif shortcut.fallback then
      hl.dispatch(shortcut.fallback)
    else
      send_shortcut(super_mods, shortcut.key)
    end
  end)
end

-- Replace Omarchy's global 1-10 workspace bindings with local slots 1-5.
-- Unbind 6-0 as well so those keys cannot jump to another monitor.
for slot = 1, 10 do
  local key = "code:" .. tostring(slot + 9)
  hl.unbind("SUPER + " .. key)
  hl.unbind("SUPER + SHIFT + " .. key)
  hl.unbind("SUPER + SHIFT + ALT + " .. key)

  if slot <= 5 then
    local workspace = "r~" .. tostring(slot)
    o.bind("SUPER + " .. key, "Switch to monitor workspace " .. slot,
      hl.dsp.focus({ workspace = workspace }))
    o.bind("SUPER + SHIFT + " .. key, "Move window to monitor workspace " .. slot,
      hl.dsp.window.move({ workspace = workspace }))
    o.bind("SUPER + SHIFT + ALT + " .. key, "Move window silently to monitor workspace " .. slot,
      hl.dsp.window.move({ workspace = workspace, follow = false }))
  end
end

-- All five slots stay alive, so m+/-1 cycles only this monitor's workspaces.
local workspace_shortcuts = {
  { "SUPER + TAB", "Next workspace on monitor", "m+1" },
  { "SUPER + SHIFT + TAB", "Previous workspace on monitor", "m-1" },
  { "SUPER + CTRL + TAB", "Former workspace on monitor", "previous_per_monitor" },
  { "SUPER + mouse_down", "Scroll monitor workspace forward", "m+1" },
  { "SUPER + mouse_up", "Scroll monitor workspace backward", "m-1" },
}
for _, shortcut in ipairs(workspace_shortcuts) do
  hl.unbind(shortcut[1])
  o.bind(shortcut[1], shortcut[2], hl.dsp.focus({ workspace = shortcut[3] }))
end
