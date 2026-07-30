vim.pack.add {
  { src = "https://github.com/folke/flash.nvim", version = "stable" },
  { src = "https://github.com/folke/trouble.nvim", version = "bd67efe408d4816e25e8491cc5ad4088e708a69a" },
  { src = "https://github.com/folke/noice.nvim", version = "7bfd942445fb63089b59f97ca487d605e715f155" },
  { src = "https://github.com/MunifTanjim/nui.nvim", version = "de740991c12411b663994b2860f1a4fd0937c130" },
  { src = "https://github.com/rcarriga/nvim-notify", version = "397c7c1184745fca649e5104de659e6392ef5a4d" },
  { src = "https://github.com/folke/snacks.nvim", version = "ad9ede6a9cddf16cedbd31b8932d6dcdee9b716e" },
}

require("trouble").setup {}
require("noice").setup()

local info = require("display").get_terminal_info()
local is_portrait = info.orientation == "portrait"
local picker_layout = {}
local explorer_layout = {}
if is_portrait then
  explorer_layout = { preset = "ivy", preview = true, layout = { position = "top", height = 30 } }
  picker_layout = { preset = "ivy", preview = true, layout = { position = "bottom" }, height = 60 }
end

require("snacks").setup {
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  debug = { enabled = true },
  explorer = { enabled = true },
  image = { enabled = true },
  indent = { enabled = true },
  input = { enabled = false },
  notifier = { enabled = true, timeout = 3000 },
  picker = {
    enabled = true,
    layout = picker_layout,
    sources = {
      explorer = { layout = explorer_layout },
      lazygit = { fullscreen = true },
    },
  },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scratch = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },

  ---@class snacks.zen.Config
  zen = {
    enabled = true,
    toggles = {
      dim = true,
      git_signs = false,
      mini_diff_signs = true,
      diagnostics = true,
      inlay_hints = true,
    },
    center = true, -- center the window
    show = {
      statusline = true, -- can only be shown when using the global statusline
      tabline = true,
    },
    win = { style = "zen" },
    zoom = {
      toggles = {},
      center = false,
      show = { statusline = true, tabline = true },
      win = {
        backdrop = true,
        width = 0,
      },
    },
  },
  styles = {
    zen = {
      enter = true,
      fixbuf = false,
      minimal = false,
      width = 160,
      height = 0,
      backdrop = { transparent = false, blend = 80 },
      keys = { q = false },
      zindex = 40,
      wo = {
        winhighlight = "NormalFloat:Normal",
      },
      w = {
        snacks_main = true,
      },
    },
    lazygit = { width = 0, height = 0 },
  },
}
