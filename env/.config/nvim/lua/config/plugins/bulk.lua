return {
  'tpope/vim-sleuth',
  'tpope/vim-eunuch',
  "tpope/vim-repeat",
  'folke/which-key.nvim',
  'nvim-lualine/lualine.nvim',
  'numToStr/Comment.nvim',
  'nyoom-engineering/oxocarbon.nvim',
  'folke/tokyonight.nvim',
  'mg979/vim-visual-multi',
  "kylechui/nvim-surround",
  "camgraff/telescope-tmux.nvim",
  'folke/lsp-colors.nvim',
  -- "tronikelis/ts-autotag.nvim",
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,         -- Auto close tags
          enable_rename = true,        -- Auto rename pairs of tags
          enable_close_on_slash = true -- Auto close on trailing </
        },
      })
    end
  },
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },
}
