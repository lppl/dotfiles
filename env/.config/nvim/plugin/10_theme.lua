vim.pack.add {
  { src = "https://github.com/folke/tokyonight.nvim",
    version = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6"},
  { src = "https://github.com/lucasadelino/conifer.nvim",
    version = "83104ae71cba003b76b0cea45cbb19bc9c62693a" },
  { src = "https://github.com/jpwol/thorn.nvim",
    version = "719f558623eb05d0e391401c419820ffb9042fb6"},
  { src = "https://github.com/EdenEast/nightfox.nvim",
    version = "26b61b1f856ec37cae3cb64f5690adb955f246a1"},
  { src = "https://github.com/morhetz/gruvbox",
    version = "697c00291db857ca0af00ec154e5bd514a79191f"},
}

require("tokyonight").setup { style = "night", transparent = true }
require("conifer").setup { transparent = true }
require('nightfox').setup {}


vim.cmd("colorscheme nightfox")



