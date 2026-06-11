local group = vim.api.nvim_create_augroup("user_session", { clear = true })

local session_name = ".nvim-session"
local marker_names = { "package.json", ".git", "init.lua", ".luarc.json", ".project" }

local active_session
local loaded_session = false

local function path_join(...)
  return table.concat(vim.tbl_map(function(part) return tostring(part) end, { ... }), "/")
end

local function exists(path) return vim.uv.fs_stat(path) ~= nil end

local function find_up(names, start)
  local dir = vim.fs.normalize(start or vim.uv.cwd())

  while dir do
    for _, name in ipairs(names) do
      local path = path_join(dir, name)
      if exists(path) then return dir, path, name end
    end

    local parent = vim.fs.dirname(dir)
    if not parent or parent == dir then return nil end
    dir = parent
  end
end

local function session_path_for(dir) return path_join(vim.fs.normalize(dir), session_name) end

local function set_active(path)
  active_session = vim.fs.normalize(path)
  vim.g.nvim_session_active = active_session
end

local function save_session()
  if not active_session then return false end

  local session_dir = vim.fs.dirname(active_session)
  if vim.fn.isdirectory(session_dir) == 0 then vim.fn.mkdir(session_dir, "p") end

  local ok, err = pcall(vim.cmd, "mksession! " .. vim.fn.fnameescape(active_session))
  if not ok then
    vim.notify("Session save failed: " .. tostring(err), vim.log.levels.ERROR)
    return false
  else
    vim.notify("Session saved: " .. vim.fn.fnameescape(active_session))
  end

  return true
end

local function load_session(path)
  if loaded_session or vim.v.this_session ~= "" then return false end

  set_active(path)
  loaded_session = true

  local ok, err = pcall(vim.cmd, "silent source " .. vim.fn.fnameescape(path))
  if not ok then
    vim.notify("Session load failed: " .. tostring(err), vim.log.levels.ERROR)
    return false
  end

  return true
end

local function init_session(dir)
  set_active(session_path_for(dir or vim.uv.cwd()))
  save_session()
  vim.notify("Session initialized: " .. active_session, vim.log.levels.INFO)
end

vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "localoptions",
}

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  nested = true,
  callback = function()
    local cwd = vim.uv.cwd()
    local session_dir, session_path = find_up({ session_name }, cwd)
    if session_path then
      vim.cmd.cd(vim.fn.fnameescape(session_dir))
      load_session(session_path)
      return
    end

    local project_dir = find_up(marker_names, cwd)
    if project_dir then set_active(session_path_for(project_dir)) end
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = save_session,
})

vim.api.nvim_create_user_command(
  "SessionInit",
  function(command) init_session(command.args ~= "" and vim.fs.abspath(command.args) or vim.uv.cwd()) end,
  {
    nargs = "?",
    complete = "dir",
    desc = "Initialize .nvim-session in the current or given directory",
  }
)

vim.api.nvim_create_user_command("SessionSave", save_session, {
  desc = "Save the active .nvim-session",
})

vim.api.nvim_create_user_command(
  "SessionLoad",
  function(command) load_session(command.args ~= "" and vim.fs.abspath(command.args) or session_path_for(vim.uv.cwd())) end,
  {
    nargs = "?",
    complete = "file",
    desc = "Load a .nvim-session file",
  }
)

vim.api.nvim_create_user_command("SessionQuit", function(command)
  save_session()
  vim.cmd(command.bang and "qall!" or "confirm qall")
end, {
  bang = true,
  desc = "Save the active session and quit Neovim",
})
