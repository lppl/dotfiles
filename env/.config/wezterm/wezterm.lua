-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night'
config.font =  wezterm.font_with_fallback {

	-- { family = 'IosevkaRootiestV2 Nerd Font', weight="Medium", stretch="SemiCondensed" },
	-- { family = 'IosevkaRootiestV2 Nerd Font', weight = 'Regular' },
	{ family = 'RecMonoCasual Nerd Font Mono', weight = 'Regular' },
}
config.line_height = 1
config.font_size = 18
-- config.cell_width = 1.1
config.cell_width = .9

local wezterm = require 'wezterm'
local act = wezterm.action

config.disable_default_key_bindings = true


local keys = {
	{ key = '-', mods = 'ALT', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
	{ key = '|', mods = 'ALT|SHIFT', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
	{ key = 'n', mods = 'ALT', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
	{ key = 'N', mods = 'ALT|SHIFT', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },

	{ key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
	{ key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

	{ key = '+', mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
	{ key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
	{ key = '0', mods = 'CTRL', action = act.ResetFontSize },

	{ key = '1', mods = 'CTRL', action = act.ActivateTab(0) },
	{ key = '2', mods = 'CTRL', action = act.ActivateTab(1) },
	{ key = '3', mods = 'CTRL', action = act.ActivateTab(2) },

	{ key = 'F', mods = 'CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },

	{ key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
	{ key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },

	{ key = 'F', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },

	{ key = 'L', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },

	-- { key = 'M', mods = 'SHIFT|CTRL', action = act.Hide },
	{ key = 'P', mods = 'ALT|CTRL', action = act.ActivateCommandPalette },
	{ key = 'R', mods = 'ALT|CTRL', action = act.ReloadConfiguration },
	{ key = 'T', mods = 'ALT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },

	{ key = 'U', mods = 'CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },

	-- { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = true } },

	{ key = 'X', mods = 'CTRL', action = act.ActivateCopyMode },
	{ key = 'X', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
	{ key = 'f', mods = 'CTRL', action = act.TogglePaneZoomState },
	{ key = 'f', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
	
	{ key = '[', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
	{ key = ']', mods = 'CTRL', action = act.ActivateTabRelative(1) },

	-- { key = 'k', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
	-- { key = 'k', mods = 'SUPER', action = act.ClearScrollback 'ScrollbackOnly' },
	
	-- { key = 'm', mods = 'SHIFT|CTRL', action = act.Hide },
	-- { key = 'm', mods = 'SUPER', action = act.Hide },
	{ key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
	{ key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
	{ key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
	{ key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
	{ key = 't', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },
	-- { key = 'z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
	{ key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
	-- { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
	-- { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
	-- { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
	-- { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
	-- { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
	-- { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
	{ key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
	{ key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
}

local key_tables = {
	copy_mode = {
		{ key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
		{ key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
		{ key = 'Enter', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
		{ key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
		{ key = 'Space', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
		{ key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
		{ key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
		{ key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
		{ key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
		{ key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
		{ key = 'F', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
		{ key = 'F', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
		{ key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
		{ key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
		{ key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
		{ key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
		{ key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
		{ key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
		{ key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
		{ key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
		{ key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
		{ key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
		{ key = 'T', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
		{ key = 'T', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
		{ key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
		{ key = 'V', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode =  'Line' } },
		{ key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
		{ key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
		{ key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
		{ key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
		{ key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
		{ key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
		{ key = 'd', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (0.5) } },
		{ key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
		{ key = 'f', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = false } } },
		{ key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
		{ key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
		{ key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
		{ key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
		{ key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
		{ key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
		{ key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
		{ key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
		{ key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent' },
		{ key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
		{ key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
		{ key = 't', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = true } } },
		{ key = 'u', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (-0.5) } },
		{ key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
		{ key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },
		{ key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
		{ key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
		{ key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
		{ key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
		{ key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
		{ key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
		{ key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
		{ key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
		{ key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
		{ key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
		{ key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
		{ key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
	},
	search_mode = {
		{ key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
		{ key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
		{ key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
		{ key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
		{ key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
		{ key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
		{ key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
		{ key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
		{ key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
		{ key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
	},
}

config.keys = keys
config.key_tables = key_tables

return config
