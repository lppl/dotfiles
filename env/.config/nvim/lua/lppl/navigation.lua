vim.keymap.set({ "n", "v" }, "<M-0>", ':only<cr>', { desc = "Close other windows" })
vim.keymap.set({ "i" }, "<M-0>", '<esc>:only<cr>i', { desc = "Close other windows" })

vim.keymap.set({ "n", "v" }, "<A-h>", ':wincmd h<cr>', { desc = "Focus split to the left" })
vim.keymap.set({ "n", "v" }, "<A-l>", ':wincmd l<cr>', { desc = "Focus split to the right" })
vim.keymap.set({ "n", "v" }, "<A-j>", ':wincmd j<cr>', { desc = "Focus bottom split" })
vim.keymap.set({ "n", "v" }, "<A-k>", ':wincmd k<cr>', { desc = "Focus up split" })

vim.keymap.set({ "n", "v" }, "<A-C-h>", '<C-w><', { desc = "Decrease window height" })
vim.keymap.set({ "n", "v" }, "<A-C-l>", '<C-w>>', { desc = "Increase window height" })
vim.keymap.set({ "n", "v" }, "<A-C-j>", ':resize -1<cr>', { desc = "Decrease window height" })
vim.keymap.set({ "n", "v" }, "<A-C-k>", ':resize +1<cr>', { desc = "Increase window height" })

vim.keymap.set({ "n", "v" }, "<A-C-i>", '<C-w>=', { desc = "Equalize windows width and height" })

-- works "good enough" with two colunmn layout
-- then 100% is a width of single buffer without gutter
vim.keymap.set({ "n", "v" }, "<A-C-y>", ':vert res 30%<cr>', { desc = "Minimize current window width" })
vim.keymap.set({ "n", "v" }, "<A-C-u>", ':vert res 130%<cr>', { desc = "Maximize current window width" })
vim.keymap.set({ "n", "v" }, "<A-C-o>", ':res 130%<cr>', { desc = "Maximize current window height" })
vim.keymap.set({ "n", "v" }, "<A-C-p>", ':res 5<cr>', { desc = "Minimize current window height" })

return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-media-files.nvim'
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              -- ['<C-d>'] = false,
            },
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'media_files')

      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '? Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '  Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '/ Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fe', require('telescope.builtin').buffers, { desc = '  Find existing buffers' })
      vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Find Help' })
      vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Find current Word' })
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Find by Grep' })
      vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Find Diagnostics' })

      vim.keymap.set('n', 'sf', require('telescope.builtin').find_files, { desc = 'Search files' })
      vim.keymap.set('n', 'sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
      vim.keymap.set('n', 'sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
      vim.keymap.set('n', 'sg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
      vim.keymap.set('n', 'sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({})

      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      vim.keymap.set("n", "<leader>ma", function() harpoon:list():append() end, { desc = "Harpoon [M]ark [A]ppend" })
      vim.keymap.set("n", "<leader>mr", function() harpoon:list():remove() end, { desc = "Harpoon [M]ark [R]emove" })

      vim.keymap.set("n", "<leader>mm", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })

      vim.keymap.set("n", "<C-A-0>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-A-1>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-A-2>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-A-3>", function() harpoon:list():select(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-A-Left>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-A-Right>", function() harpoon:list():next() end)

      -- Toggle previous & next buffers nvim buffers
      vim.keymap.set("n", "<C-A-S-Left>", ":bn<cr>")
      vim.keymap.set("n", "<C-A-S-Right>", ":bp<cr>")
    end
  },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      -- { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    }
  },
  {
    "camgraff/telescope-tmux.nvim"
  }
}
