vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  'tpope/vim-eunuch',

  require('lppl.lsp'),

  require('lppl.oil'),

  require('lppl.cmp'),

  -- require('lppl.ai-codecompanion'),

  require('lppl.ai-avante'),

  require('lppl.snacks'),

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },


  require('lppl.treesitter'),
  { 'rose-pine/neovim',                   as = 'rose-pine' },
  { 'polirritmico/monokai-nightasty.nvim' },
  { 'nyoom-engineering/oxocarbon.nvim' },
  { 'rebelot/kanagawa.nvim' },
  { 'folke/tokyonight.nvim' },
  require('lppl.nvim-tree'),
  -- Multicursor support
  'mg979/vim-visual-multi',
  require("lppl.git"),
  require("lppl.navigation"),
  require("lppl.format"),
  require('lppl.surround'),
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
      vim.keymap.set({ "n", "v" }, 'se', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },
  {
    "smithbm2316/centerpad.nvim",
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>Centerpad<cr>', { silent = true, noremap = true })
    end,
  },
}, {})

-- [[ Setting optio ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Theme setup
vim.cmd("set background=dark")
vim.cmd('colorscheme oxocarbon')

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ 'n', 'v' }, ';', ':', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, 's', '<Nop>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, 'ss', ':w<cr>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, 'sq', ':wq<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-A-q>', ':qall!<cr>:q<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-q>', ':bd!<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-w>', ':w<cr>:bd<cr>', { silent = true })
vim.keymap.set({ 'v' }, '<C-/>', ':norm gc', { silent = true })
vim.keymap.set({ 'n' }, '<C-/>', ':norm gcc', { silent = true })


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
