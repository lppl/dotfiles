return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ":TSUpdate",
  config = function ()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'c', 'go', 'javascript', 'lua', 'markdown', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'json', 'yaml'},
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      incremental_selection = {
        -- enable = true,
        -- keymaps = {
        --   init_selection = '<c-space>',
        --   node_incremental = '<c-space>',
        --   scope_incremental = '<c-s>',
        --   node_decremental = '<a-space>',
        -- },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- ['aa'] = '@parameter.outer',
            -- ['ia'] = '@parameter.inner',
            -- ['af'] = '@function.outer',
            -- ['if'] = '@function.inner',
            -- ['ac'] = '@class.outer',
            -- ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, 
          goto_next_start = {
            -- [']m'] = '@function.outer',
            -- [']]'] = '@class.outer',
          },
          goto_next_end = {
            -- [']m'] = '@function.outer',
            -- [']['] = '@class.outer',
          },
          goto_previous_start = {
            -- ['[m'] = '@function.outer',
            -- ['[['] = '@class.outer',
          },
          goto_previous_end = {
            -- ['[m'] = '@function.outer',
            -- ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            -- ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            -- ['<leader>a'] = '@parameter.inner',
          },
        },
      },
    }
  end
}

