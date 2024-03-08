return {
  {
    'tpope/vim-fugitive',
    config = function ()
      vim.keymap.set('n', '<leader>gg', ':DiffviewOpen<cr>', { desc = 'Diffview Open' })
      vim.keymap.set('n', '<leader>gk', ':Git commit<cr>', { desc = '[G]it [C]ommit' })
      vim.keymap.set('n', '<leader>ga', ':Git add %:p<cr>', { desc = '[G]it [A]add current file' })
      vim.keymap.set('n', '<leader>gb', ':Git blame<cr>', { desc = '[G]it [B]lame' })
      vim.keymap.set('n', '<leader>gs', ':Git status<cr>', { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gpl', ':Git pull<cr>', { desc = '[G]it [P]ul[L]' })
      vim.keymap.set('n', '<leader>gps', ':Git push<cr>', { desc = '[G]it [P]u[S]h' })
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
