return {
  { 
    'tpope/vim-fugitive',
    config = function ()
      vim.keymap.set('n', '<leader>gc', ':Git commit<cr>', { desc = '[G]it [C]ommit' })
      vim.keymap.set('n', '<leader>ga', ':Git add %:p<cr>', { desc = '[G]it [A]add current file' })
      vim.keymap.set('n', '<leader>gb', ':Git blame<cr>', { desc = '[G]it [B]lame' })
    end
  },
  'tpope/vim-rhubarb',
  { 
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      -- signs = {
      --   add = { text = '+' },
      --   change = { text = '±' },
      --   delete = { text = '-' },
      --   topdelete = { text = '‾' },
      --   changedelete = { text = '~' },
      -- },
    },
  },
}
