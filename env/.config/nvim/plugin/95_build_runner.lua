local last_script = nil
local term_bufs = {} -- script_path -> bufnr, persists across runs
local script_order = {} -- insertion-ordered list of script paths for cycling
local term_win_id = nil

local function run_in_terminal(script)
  last_script = script
  local orig_win = vim.api.nvim_get_current_win()

  if term_win_id and vim.api.nvim_win_is_valid(term_win_id) then
    vim.api.nvim_set_current_win(term_win_id)
  else
    vim.cmd("vsplit")
    term_win_id = vim.api.nvim_get_current_win()
  end

  -- Register script in cycle order on first run
  if not term_bufs[script] then script_order[#script_order + 1] = script end

  local old_buf = term_bufs[script]

  local shell = script:match("%.fish$") and "fish" or "bash"
  vim.cmd("terminal " .. shell .. " " .. vim.fn.shellescape(script))
  term_bufs[script] = vim.api.nvim_get_current_buf()

  -- Delete old buffer after the new terminal is running to avoid TermClose side-effects
  if old_buf and vim.api.nvim_buf_is_valid(old_buf) and old_buf ~= term_bufs[script] then
    pcall(vim.api.nvim_buf_delete, old_buf, { force = true })
  end

  if vim.api.nvim_win_is_valid(orig_win) then
    vim.api.nvim_set_current_win(orig_win)
  end
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
      if item then
        vim.schedule(function() run_in_terminal(item.file) end)
      end
    end,
  })
end

local function cycle_scripts()
  -- Collect only still-valid buffers in run order
  local valid = {}
  for _, script in ipairs(script_order) do
    local bufnr = term_bufs[script]
    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then valid[#valid + 1] = { script = script, bufnr = bufnr } end
  end

  if #valid == 0 then
    vim.notify("No script buffers to cycle through", vim.log.levels.WARN)
    return
  end

  local orig_win = vim.api.nvim_get_current_win()

  if not (term_win_id and vim.api.nvim_win_is_valid(term_win_id)) then
    vim.cmd("vsplit")
    term_win_id = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(orig_win)
  end

  local cur_buf = vim.api.nvim_win_get_buf(term_win_id)
  local next_entry = valid[1]
  for i, entry in ipairs(valid) do
    if entry.bufnr == cur_buf then
      next_entry = valid[(i % #valid) + 1]
      break
    end
  end

  vim.api.nvim_win_set_buf(term_win_id, next_entry.bufnr)
  last_script = next_entry.script
  vim.notify(vim.fn.fnamemodify(next_entry.script, ":t"), vim.log.levels.INFO)
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
vim.keymap.set("n", "<F12>", cycle_scripts, { desc = "Cycle script output buffers" })
