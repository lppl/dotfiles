vim.pack.add {
  { src = 'https://github.com/nvim-mini/mini.icons',    version = "stable" },
  { src = 'https://github.com/nvim-mini/mini.align',    version = "stable" },
  { src = 'https://github.com/nvim-mini/mini.surround', version = "stable" },
}

require('mini.icons').setup {}
require('mini.align').setup {}
require('mini.surround').setup {}
