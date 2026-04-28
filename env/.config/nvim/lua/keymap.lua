M = {}

vim.pack.add { "https://github.com/folke/which-key.nvim" }
local wk = require("which-key")
wk.setup {}

local function split(str)
  local t = {}
  for c in str:gmatch(".") do
    table.insert(t, c)
  end
  return t
end

---@class MapParams
---@field [1] string Key sequence (keys)
---@field [2] function|string Function or command to execute (fn)
---@field [3] string|nil Mapping description
---@field mode? string|string[] Vim mode(s) (default: "n")
---@field desc? string Mapping description
---@field silent? boolean Suppress command echo (default: true)
---@field noremap? boolean Disable recursive mapping (default: true)
---@field expr? boolean Whether fn returns an expression to evaluate
---@field buffer? integer|boolean Buffer number or true for current buffer
---@field nowait? boolean Do not wait for further keystrokes
---@field remap? boolean Allow recursive remapping

local RESERVED = { [1] = true, [2] = true, [3] = true, [4] = true, mode = true }

---Registers a key mapping in Neovim
---@param parameters MapParams
M.map = function(parameters)
  vim.validate {
    mode = { parameters.mode, "string", true },
    keys = { parameters[1], "string" },
    fn = { parameters[2], { "function", "string" } },
    desc = { parameters.desc, "string", true },
  }

  local mode = split(parameters.mode or "n")
  local keys = parameters[1]
  local fn = parameters[2]
  local desc = parameters[3] or parameters.desc or "No description provided"

  local opts = { noremap = true, silent = true }
  for k, v in pairs(parameters) do
    if not RESERVED[k] then opts[k] = v end
  end
  opts.desc = desc

  vim.keymap.set(mode, keys, fn, opts)
end

---Registers a key mapping with `<leader>` prepended to the key sequence
---@param parameters MapParams
M.lead = function(parameters)
  parameters[1] = "<leader>" .. parameters[1]
  M.map(parameters)
end

---Registers a key mapping with `<leader>` prepended to the key sequence
---@param parameters MapParams
M.cmd = function(parameters)
  vim.validate {
    cmd = { parameters[2], "string" },
  }
  parameters[2] = "<CMD>" .. parameters[2] .. "<CR>"
  M.map(parameters)
end

---Registers a visual key mapping
---@param parameters MapParams
M.visual = function(parameters)
  parameters.mode = parameters.mode or "v"
  M.map(parameters)
end

---Registers a insert key mapping
---@param parameters MapParams
M.insert = function(parameters)
  parameters.mode = parameters.mode or "i"
  M.map(parameters)
end

---Registers a terminal key mapping
---@param parameters MapParams
M.terminal = function(parameters)
  parameters.mode = parameters.mode or "t"
  M.map(parameters)
end

---Registers a multi key mapping
M.multi = function(parameters)
  parameters.mode = parameters[1] or "n"
  parameters[1] = parameters[2]
  parameters[2] = parameters[3]
  parameters[3] = parameters[4]
  parameters[4] = nil

  M.map(parameters)
end

---Registers which-key group
M.group = function(parameters)
  vim.validate {
    mode = { parameters[1], "string" },
    prefix = { parameters[2], "string" },
    group = { parameters[3], "string" },
  }
  wk.add { parameters[2], group = parameters[3], mode = split(parameters[1]) }
end

---Registers textobject query
--- @example map_query { "xo", "i(", select_textobject, "@call.inner" }
--- @example map_query { "nxo", "]f", move.goto_next_start, "@function.outer" }
M.map_query = function(parameters)
  local modes = parameters[1]
  local keys = parameters[2]
  local fn = parameters[3]
  local query = parameters[4]
  local desc = ""
  if type(query) == "table" then
    desc = table.concat(query, ",")
  else
    desc = query
  end
  M.multi { modes, keys, function() fn(query, "textobjects") end, desc }
end

M.normal = M.map
M.leader = M.lead

return M
