local last_script = nil
local term_bufs = {} -- script_path -> bufnr, persists across runs
local term_win_id = nil

local function run_in_terminal(script)
  last_script = script
  local orig_win = vim.api.nvim_get_current_win()

  if term_win_id and vim.api.nvim_win_is_valid(term_win_id) then
    vim.api.nvim_set_current_win(term_win_id)
  else
    vim.cmd("topleft vsplit")
    term_win_id = vim.api.nvim_get_current_win()
  end

  -- Wipe previous run buffer for this script only
  local old_buf = term_bufs[script]
  if old_buf and vim.api.nvim_buf_is_valid(old_buf) then pcall(vim.api.nvim_buf_delete, old_buf, { force = true }) end

  local shell = script:match("%.fish$") and "fish" or "bash"
  vim.cmd("terminal " .. shell .. " " .. vim.fn.shellescape(script))
  term_bufs[script] = vim.api.nvim_get_current_buf()

  vim.api.nvim_set_current_win(orig_win)
end

local function pick_script()
  local raw = vim.fn.systemlist("fd --type f -e sh -e fish")
  if vim.v.shell_error ~= 0 or #raw == 0 then
    vim.notify("No .sh/.fish scripts found (fd)", vim.log.levels.WARN)
    return
  end

  local items = {}
  for _, rel in ipairs(raw) do
    items[#items + 1] = { text = rel, file = vim.fn.fnamemodify(rel, ":p") }
  end

  Snacks.picker.pick("scripts", {
    title = "Run Script",
    finder = function() return items end,
    format = "text",
    confirm = function(picker, item)
      picker:close()
      if item then run_in_terminal(item.file) end
    end,
  })
end

local function rerun()
  if last_script then
    run_in_terminal(last_script)
  else
    pick_script()
  end
end

vim.keymap.set("n", "<F10>", pick_script, { desc = "Pick script to run" })
vim.keymap.set("n", "<F9>", rerun, { desc = "Rerun last script" })
