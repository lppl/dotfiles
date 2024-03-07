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
    vim.keymap.set({"n", "v"}, "<A-1>", ":NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
    vim.keymap.set({"i"}, "<A-1>", "<Esc>:NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
  end,
}
