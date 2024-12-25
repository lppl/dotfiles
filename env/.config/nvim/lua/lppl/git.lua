return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gg', ':DiffviewOpen<cr>', { desc = 'Diffview Open' })
      vim.keymap.set('n', '<leader>gc', ':DiffviewClose<cr>', { desc = 'Diffview Open' })
      vim.keymap.set('n', '<leader>gk', ':Git commit<cr>', { desc = 'Git Commit' })
      vim.keymap.set('n', '<leader>ga', ':Git add %:p<cr>', { desc = 'Git Aad current file' })
      vim.keymap.set('n', '<leader>gb', ':Git blame<cr>', { desc = 'Git Blame' })
      vim.keymap.set('n', '<leader>gs', ':Git status<cr>', { desc = 'Git Status' })
      vim.keymap.set('n', '<leader>gpull', ':Git pull<cr>', { desc = 'Git PulL' })
      vim.keymap.set('n', '<leader>gpush', ':Git push<cr>', { desc = 'Git PuSh' })
    end
  },
  'tpope/vim-rhubarb',
  'sindrets/diffview.nvim',
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
