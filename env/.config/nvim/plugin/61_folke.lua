vim.pack.add{
  { src = 'https://github.com/folke/flash.nvim', version = "stable" },
}


vim.pack.add{
  { src = 'https://github.com/folke/trouble.nvim',
    version = "bd67efe408d4816e25e8491cc5ad4088e708a69a" },
}

require('trouble').setup {}

vim.pack.add{
  { src = 'https://github.com/folke/snacks.nvim',
    version = "ad9ede6a9cddf16cedbd31b8932d6dcdee9b716e" },
}


require('snacks').setup {
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = false  },
  notifier = { enabled = true, timeout = 3000 },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}

_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end

if vim.fn.has("nvim-0.11") == 1 then
  vim._print = function(_, ...)
   dd(...)
  end
else
  vim.print = _G.dd
end

