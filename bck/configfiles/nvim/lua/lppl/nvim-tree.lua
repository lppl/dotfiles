-- disable netrw as soon as this file is required by init.lua
-- this satisfies nvim-tree requirement to make it at the beginning
-- of init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  config = function()
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })
    vim.keymap.set({"n", "v"}, "<M-1>", ":NvimTreeFocus<cr>", { desc = "Nvimtree Focus" })
    vim.keymap.set({"i"}, "<M-1>", "<esc>:NvimTreeFocus<cr>", { desc = "Nvimtree Focus" })
  end,
}
