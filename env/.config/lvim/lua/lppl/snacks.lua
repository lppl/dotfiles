local keys = {
  -- Top Pickers & Explorer
  { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
  { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
  { "leader>/",        function() Snacks.picker.grep() end,                                    desc = "Grep" },
  { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
  { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
  { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
  -- find
  { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
  { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
  { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
  { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
  { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
  -- git
  { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
  { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
  { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
  { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
  { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
  { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
  { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
  -- Grep
  { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
  { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
  { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
  -- search
  { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
  { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
  { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
  { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
  { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
  { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
  { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
  { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
  { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
  { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
  { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
  { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
  { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
  { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
  { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
  { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
  { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
  { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
  { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
  { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
  -- LSP
  { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
  { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
  { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
  { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
  { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
  { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
  { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
  -- Other
  { "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
  { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
  { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
  { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
  { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
  { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
  { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
  { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
  { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
  { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
  { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
  { "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
  { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
  { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
  {
    "<leader>N",
    desc = "Neovim News",
    function()
      Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
          spell = false,
          wrap = false,
          signcolumn = "yes",
          statuscolumn = " ",
          conceallevel = 3,
        },
      })
    end,
  }
}


local function includes(str, sign)
  return string.find(str, sign) ~= nil
end

local function getItemByPath(item, path)
  local current = item
  for i = 1, #path do
    local key = path:sub(i, i)
    if i == #path then
      return current
    else
      current[key] = current[key] or {}
      current = current[key]
    end
  end
end


local function setItemByPath(item, path, value)
  local current = item
  for i = 1, #path do
    local key = path:sub(i, i)
    if i == #path then
      current[key] = value
    else
      current[key] = current[key] or {}
      current = current[key]
    end
  end
end

---@param container array The container in which we set key.
---@param path string The path to assign the function to.
---@param fn function The function to be assigned.
---@param desc string|nil A description for the function.
---@param modes string|nil The modes in which the keybinding is active, default is "nv".
---@param prefix string|nil Prefix to desc, default is "Snack: ".
local function assign(path, fn, desc, modes, prefix)
  modes = modes or "nv"
  prefix = prefix or "Snack: "
  if desc then
    desc = prefix .. desc
  end
  if includes(modes, "n") then
    setItemByPath(lvim.builtin.which_key.mappings, path, { fn, desc })
  end
  if includes(modes, "v") then
    setItemByPath(lvim.builtin.which_key.vmappings, path, { fn, desc })
  end
end

---@param path string The path to assign the function to.
---@param name string|nil A name for a container.
---@param modes string|nil The modes in which the keybinding is active, default is "nv".
local function setName(path, name, modes)
  modes = modes or "nv"
  if includes(modes, "n") then
    getItemByPath(lvim.builtin.which_key.mappings, path).name = name
  end
  if includes(modes, "v") then
    getItemByPath(lvim.builtin.which_key.vmappings, path).name = name
  end
end

---@param path string The path to assign the function to.
---@param modes string|nil The modes in which the keybinding is active, default is "nv".
local function remove(path, modes)
  modes = modes or "nv"
  if includes(modes, "n") then
    setItemByPath(lvim.builtin.which_key.mappings, path, false)
  end
  if includes(modes, "v") then
    setItemByPath(lvim.builtin.which_key.vmappings, path, false)
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    animation = { enabled = true },
    bigfile = { enabled = true },
    explorer = {
      enabled = true,
      replace_netrw = true
    },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true
    },
    rename = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },

  plugins = {
    marks = true,     -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true,    -- adds help for operators like d, y, ...
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  keys = keys,
  config = function()
    -- assign("z", function() Snacks.zen() end, "Toggle Zen Mode")
    -- assign("sg", function() Snacks.picker.grep() end, "Grep")

    -- remove("f")
    -- setName("f", "Find in ...")
    -- assign("fb", function() Snacks.picker.buffers() end, "Buffers")
    -- assign("fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, "Find Config File")
    -- assign("ff", function() Snacks.picker.files() end, "Find Files")
    -- assign("fg", function() Snacks.picker.git_files() end, "Find Git Files")
    -- assign("fp", function() Snacks.picker.projects() end, "Projects")
    -- assign("fr", function() Snacks.picker.recent() end, "Recent")
  end
}
