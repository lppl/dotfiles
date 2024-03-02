return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      local harpoon = require("harpoon")

      harpoon:setup()

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

      vim.keymap.set("n", "sa", function() harpoon:list():append() end)

      -- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })

      vim.keymap.set("n", "<C-A-0>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-A-1>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-A-2>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-A-3>", function() harpoon:list():select(4) end)

      -- -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-A-Left>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-A-Right>", function() harpoon:list():next() end)

      -- -- Toggle previous & next buffers nvim buffers 
      vim.keymap.set("n", "<C-A-S-Left>", ":bn<cr>")
      vim.keymap.set("n", "<C-A-S-Right>", ":bp<cr>")
    end
  },
  { 'ThePrimagean/git-worktree.nvim'}
}


-- -- op = Operations.Switch, Operations.Create, Operations.Delete
-- -- metadata = table of useful values (structure dependent on op)
-- --      Switch
-- --          path = path you switched to
-- --          prev_path = previous worktree path
-- --      Create
-- --          path = path where worktree created
-- --          branch = branch name
-- --          upstream = upstream remote name
-- --      Delete
-- --          path = path where worktree deleted
--
-- local Worktree = require("git-worktree")
-- Worktree.on_tree_change(function(op, metadata)
--   if op == Worktree.Operations.Switch then
--     print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
--   end
-- end)
--
-- require("telescope").load_extension("git_worktree")
-- vim.keymap.set("n", "gwc", require('telescope').extensions.git_worktree.create_git_worktree, { desc = "[G]it [W]orktree [C]reate" })
-- vim.keymap.set("n", "gww", require('telescope').extensions.git_worktree.git_worktree, { desc = "[G]it [W]orktree [W]worktree" })
-- -- vim.keymap.set("n", "gws", require('telescope').extensions.git_worktree.switch_git_worktree)
-- -- vim.keymap.set("n", "gwd", require('telescope').extensions.git_worktree.delete_git_worktree)
-- vim.keymap.set({"n", "v"}, "<A-1>", ":NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
-- vim.keymap.set({"i"}, "<A-1>", "<Esc>:NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
--
--
