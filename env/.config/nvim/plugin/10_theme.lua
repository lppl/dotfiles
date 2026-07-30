vim.pack.add {
  { src = "https://github.com/folke/tokyonight.nvim", version = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6" },
  -- { src = "https://github.com/lucasadelino/conifer.nvim", version = "b4e626afefef996dba67226ad50c49dc0b67f6dd" },
  -- { src = "https://github.com/jpwol/thorn.nvim", version = "719f558623eb05d0e391401c419820ffb9042fb6" },
  -- { src = "https://github.com/EdenEast/nightfox.nvim", version = "26b61b1f856ec37cae3cb64f5690adb955f246a1" },
  -- { src = "https://github.com/morhetz/gruvbox", version = "697c00291db857ca0af00ec154e5bd514a79191f" },
  { src = "https://github.com/folke/styler.nvim", version = "d73d868541a2536a96d057c793d53c50e5f407bb" },
}
require("tokyonight").setup { style = "night", transparent = true }
-- require("conifer").setup { transparent = true }
-- require("nightfox").setup {}

local light = "tokyonight-day"
local dark = "tokyonight-night"

-- local light = "conifer-solar"
-- local dark = "conifer-lunar"

local function set_theme(background)
  local theme = background == "light" and light or dark
  if vim.g.colors_name == theme then return end

  vim.cmd.colorscheme(theme)
  if background == "dark" then
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#332255" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#440033" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#220022" })
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#332255" })
  end
end

vim.api.nvim_create_autocmd("TermResponse", {
  desc = "Match colorscheme to terminal background",
  callback = function(event)
    local red, green, blue = event.data.sequence:match("\27%]11;rgb:(%x+)/(%x+)/(%x+)")
    if not red then return end

    local function channel(hex) return tonumber(hex, 16) / (16 ^ #hex - 1) end
    local luminance = 0.299 * channel(red) + 0.587 * channel(green) + 0.114 * channel(blue)
    set_theme(luminance > 0.5 and "light" or "dark")
  end,
})

set_theme(vim.o.background)
vim.api.nvim_ui_send("\27]11;?\27\\")

require("styler").setup {
  themes = {
    lualine = { colorscheme = "nightfox" },
  },
}
