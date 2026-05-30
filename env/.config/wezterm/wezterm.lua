-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.disable_default_key_bindings = true
-- config.color_scheme = "Tokyo Night"
config.color_scheme = "carbonfox"
config.font = wezterm.font_with_fallback({
  { family = "RecMonoCasual Nerd Font Mono", weight = "Regular" },
  { family = "0xProto Nerd Font Propo", weight = "Regular" },
})
config.harfbuzz_features = { "zero" }
config.line_height = 1
config.font_size = 12
config.cell_width = 0.9
config.hide_tab_bar_if_only_one_tab = true
config.enable_kitty_graphics = true

local function makeKeyForMod(mod)
  return function(key_fn)
    return {
      key = key_fn[1] or key_fn.key,
      mods = key_fn.mods or mod,
      action = key_fn[2] or key_fn.action,
    }
  end
end

local key = makeKeyForMod("NONE")
local ctrl = makeKeyForMod("CTRL")
local alt = makeKeyForMod("ALT")
local alt_ctrl = makeKeyForMod("ALT|CTRL")
local super = makeKeyForMod("SUPER")
local shift = makeKeyForMod("SHIFT")
local none = makeKeyForMod("NONE")

local keys = {
  alt_ctrl({ "f", act.TogglePaneZoomState }),
  alt_ctrl({ "n", act.SplitVertical({ domain = "CurrentPaneDomain" }) }),
  alt_ctrl({ "N", act.SplitHorizontal({ domain = "CurrentPaneDomain" }) }),

  alt({ "h", act.ActivatePaneDirection("Left") }),
  alt({ "l", act.ActivatePaneDirection("Right") }),
  alt({ "k", act.ActivatePaneDirection("Up") }),
  alt({ "j", act.ActivatePaneDirection("Down") }),

  alt_ctrl({ "KeypadMultiply", act.IncreaseFontSize }),
  alt_ctrl({ "KeypadDivide", act.DecreaseFontSize }),
  alt_ctrl({ "0", act.ResetFontSize }),

  alt_ctrl({ "1", act.ActivateTab(0) }),
  alt_ctrl({ "2", act.ActivateTab(1) }),
  alt_ctrl({ "3", act.ActivateTab(2) }),

  ctrl({ "F", act.Search("CurrentSelectionOrEmptyString") }),

  ctrl({ "C", act.CopyTo("Clipboard") }),
  ctrl({ "V", act.PasteFrom("Clipboard") }),

  ctrl({ "L", act.ShowDebugOverlay }),

  none({ "F11", act.ToggleFullScreen }),
  ctrl({ "M", act.Hide }),
  alt_ctrl({ "R", act.ReloadConfiguration }),
  alt_ctrl({ "T", act.SpawnTab("CurrentPaneDomain") }),

  ctrl({ "U", act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }) }),

  ctrl({ "X", act.ActivateCopyMode }),

  alt_ctrl({ "W", act.CloseCurrentTab({ confirm = true }) }),
  alt_ctrl({ "t", act.SpawnTab("CurrentPaneDomain") }),
  ctrl({ "PageUp", act.ActivateTabRelative(-1) }),
  ctrl({ "PageUp", act.MoveTabRelative(-1) }),

  -- ctrl { 'k', act.ClearScrollback 'ScrollbackOnly' },
  -- super { 'k', act.ClearScrollback 'ScrollbackOnly' },

  -- ctrl { 'm', act.Hide },
  -- super { 'm', act.Hide },
  alt_ctrl({ "p", act.ActivateCommandPalette }),
  alt_ctrl({ "r", act.ReloadConfiguration }),
  super({ "r", act.ReloadConfiguration }),
  alt({ "Z", act.TogglePaneZoomState }),
  ctrl({ "phys:Space", act.QuickSelect }),
  -- key { 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  -- ctrl { 'PageUp', act.ActivateTabRelative(-1) },
  -- ctrl { 'PageUp', act.MoveTabRelative(-1) },
  -- key { 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
  -- ctrl { 'PageDown', act.ActivateTabRelative(1) },
  -- ctrl { 'PageDown', act.MoveTabRelative(1) },
  key({ "Copy", act.CopyTo("Clipboard") }),
  key({ "Paste", act.PasteFrom("Clipboard") }),
}

local key_tables = {
  copy_mode = {
    key({ "Tab", act.CopyMode("MoveForwardWord") }),
    shift({ "Tab", act.CopyMode("MoveBackwardWord") }),
    key({ "Enter", act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }) }),
    key({ "Escape", act.CopyMode("Close") }),
    key({ "Space", act.CopyMode({ SetSelectionMode = "Cell" }) }),
    key({ "$", act.CopyMode("MoveToEndOfLineContent") }),
    key({ ",", act.CopyMode("JumpReverse") }),
    key({ "0", act.CopyMode("MoveToStartOfLine") }),
    key({ ";", act.CopyMode("JumpAgain") }),
    key({ "F", act.CopyMode({ JumpBackward = { prev_char = false } }) }),
    key({ "G", act.CopyMode("MoveToScrollbackBottom") }),
    key({ "H", act.CopyMode("MoveToViewportTop") }),
    key({ "L", act.CopyMode("MoveToViewportBottom") }),
    key({ "M", act.CopyMode("MoveToViewportMiddle") }),
    key({ "O", act.CopyMode("MoveToSelectionOtherEndHoriz") }),
    key({ "T", act.CopyMode({ JumpBackward = { prev_char = true } }) }),
    key({ "V", act.CopyMode({ SetSelectionMode = "Line" }) }),
    key({ "^", act.CopyMode("MoveToStartOfLineContent") }),
    key({ "b", act.CopyMode("MoveBackwardWord") }),
    alt({ "b", act.CopyMode("MoveBackwardWord") }),
    ctrl({ "b", act.CopyMode("PageUp") }),
    ctrl({ "c", act.CopyMode("Close") }),
    ctrl({ "d", act.CopyMode({ MoveByPage = 0.5 }) }),
    key({ "e", act.CopyMode("MoveForwardWordEnd") }),
    key({ "f", act.CopyMode({ JumpForward = { prev_char = false } }) }),
    alt({ "f", act.CopyMode("MoveForwardWord") }),
    ctrl({ "f", act.CopyMode("PageDown") }),
    key({ "g", act.CopyMode("MoveToScrollbackTop") }),
    ctrl({ "g", act.CopyMode("Close") }),
    key({ "h", act.CopyMode("MoveLeft") }),
    key({ "j", act.CopyMode("MoveDown") }),
    key({ "k", act.CopyMode("MoveUp") }),
    key({ "l", act.CopyMode("MoveRight") }),
    alt({ "m", act.CopyMode("MoveToStartOfLineContent") }),
    key({ "o", act.CopyMode("MoveToSelectionOtherEnd") }),
    key({ "q", act.CopyMode("Close") }),
    key({ "t", act.CopyMode({ JumpForward = { prev_char = true } }) }),
    ctrl({ "u", act.CopyMode({ MoveByPage = -0.5 }) }),
    key({ "v", act.CopyMode({ SetSelectionMode = "Cell" }) }),
    ctrl({ "v", act.CopyMode({ SetSelectionMode = "Block" }) }),
    key({ "w", act.CopyMode("MoveForwardWord") }),
    key({ "y", act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }) }),
    key({ "PageUp", act.CopyMode("PageUp") }),
    key({ "PageDown", act.CopyMode("PageDown") }),
    key({ "End", act.CopyMode("MoveToEndOfLineContent") }),
    key({ "Home", act.CopyMode("MoveToStartOfLine") }),
    key({ "LeftArrow", act.CopyMode("MoveLeft") }),
    alt({ "LeftArrow", act.CopyMode("MoveBackwardWord") }),
    key({ "RightArrow", act.CopyMode("MoveRight") }),
    alt({ "RightArrow", act.CopyMode("MoveForwardWord") }),
    key({ "UpArrow", act.CopyMode("MoveUp") }),
    key({ "DownArrow", act.CopyMode("MoveDown") }),
  },
  search_mode = {
    key({ "Enter", act.CopyMode("PriorMatch") }),
    key({ "Escape", act.CopyMode("Close") }),
    ctrl({ "n", act.CopyMode("NextMatch") }),
    ctrl({ "p", act.CopyMode("PriorMatch") }),
    ctrl({ "r", act.CopyMode("CycleMatchType") }),
    ctrl({ "u", act.CopyMode("ClearPattern") }),
    key({ "PageUp", act.CopyMode("PriorMatchPage") }),
    key({ "PageDown", act.CopyMode("NextMatchPage") }),
    key({ "UpArrow", act.CopyMode("PriorMatch") }),
    key({ "DownArrow", act.CopyMode("NextMatch") }),
  },
}

config.keys = keys
config.key_tables = key_tables

return config
