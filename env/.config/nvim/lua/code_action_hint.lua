local M = {}

local ns = vim.api.nvim_create_namespace("code_action_hint")
local augroup = vim.api.nvim_create_augroup("user_code_action_hint", { clear = true })
local timers = {}
local generations = {}

M.kinds = { "quickfix" }

vim.api.nvim_set_hl(0, "CodeActionHintUnderline", { underline = true })

local function action_kind_matches(kind)
  if not kind then return false end

  for _, allowed in ipairs(M.kinds) do
    if kind == allowed or vim.startswith(kind, allowed .. ".") then return true end
  end

  return false
end

local function has_matching_action(actions)
  if type(actions) ~= "table" then return false end

  for _, action in ipairs(actions) do
    if not action.disabled and action_kind_matches(action.kind) then return true end
  end

  return false
end

local function diagnostic_range(diagnostic)
  local start_line = diagnostic.lnum
  local start_col = diagnostic.col or 0
  local end_line = diagnostic.end_lnum or start_line
  local end_col = diagnostic.end_col or start_col + 1

  if end_line == start_line and end_col <= start_col then end_col = start_col + 1 end

  return {
    start = { line = start_line, character = start_col },
    ["end"] = { line = end_line, character = end_col },
  }
end

local function code_action_params(buf, diagnostic, client)
  local lsp_diagnostic = diagnostic.user_data and diagnostic.user_data.lsp
  local range = diagnostic_range(diagnostic)
  local params = vim.lsp.util.make_given_range_params(
    { range.start.line + 1, range.start.character },
    { range["end"].line + 1, range["end"].character },
    buf,
    client.offset_encoding
  )

  params.context = {
    diagnostics = lsp_diagnostic and { lsp_diagnostic } or {},
    only = M.kinds,
  }

  return params
end

local function clients(buf)
  return vim.tbl_filter(
    function(client) return client:supports_method("textDocument/codeAction", buf) end,
    vim.lsp.get_clients { bufnr = buf }
  )
end

local function mark(buf, diagnostic)
  local range = diagnostic_range(diagnostic)

  vim.api.nvim_buf_set_extmark(buf, ns, range.start.line, range.start.character, {
    end_row = range["end"].line,
    end_col = range["end"].character,
    hl_group = "CodeActionHintUnderline",
    hl_mode = "combine",
    priority = 200,
  })
end

function M.refresh(buf)
  if not vim.api.nvim_buf_is_valid(buf) then return end

  local available_clients = clients(buf)
  if #available_clients == 0 then return end

  generations[buf] = (generations[buf] or 0) + 1
  local generation = generations[buf]
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  local diagnostics = vim.diagnostic.get(buf)
  if #diagnostics == 0 then return end

  for _, diagnostic in ipairs(diagnostics) do
    for _, client in ipairs(available_clients) do
      client:request("textDocument/codeAction", code_action_params(buf, diagnostic, client), function(err, result)
        if err or generations[buf] ~= generation or not has_matching_action(result) then return end

        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(buf) and generations[buf] == generation then mark(buf, diagnostic) end
        end)
      end, buf)
    end
  end
end

function M.schedule_refresh(buf)
  if timers[buf] then
    timers[buf]:stop()
    timers[buf]:close()
  end

  local timer = assert((vim.uv or vim.loop).new_timer())
  timers[buf] = timer

  timer:start(150, 0, function()
    timer:stop()
    timer:close()
    timers[buf] = nil

    vim.schedule(function() M.refresh(buf) end)
  end)
end

function M.setup_buffer(buf)
  if vim.b[buf].code_action_hint_attached then
    M.schedule_refresh(buf)
    return
  end

  vim.b[buf].code_action_hint_attached = true

  vim.api.nvim_create_autocmd({ "BufEnter", "DiagnosticChanged", "InsertLeave" }, {
    group = augroup,
    buffer = buf,
    callback = function(args) M.schedule_refresh(args.buf) end,
  })

  M.schedule_refresh(buf)
end

function M.code_action()
  vim.lsp.buf.code_action {
    context = {
      only = M.kinds,
    },
  }
end

return M
