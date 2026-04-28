-- ═══════════════════════════════════════════════════════════
-- Diagnostics settings
-- ═══════════════════════════════════════════════════════════

local palette = {
  err = "#51202A",
  warn = "#3B3B1B",
  info = "#1F3342",
  hint = "#1E2E1E",
}

vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { bg = palette.err, blend = 20 })
vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { bg = palette.warn, blend = 15 })
vim.api.nvim_set_hl(0, "DiagnosticInfoLine", { bg = palette.info, blend = 10 })
vim.api.nvim_set_hl(0, "DiagnosticHintLine", { bg = palette.hint, blend = 10 })

vim.api.nvim_set_hl(0, "DapBreakpointSign", { fg = "#FF0000", bg = nil, bold = true })
vim.fn.sign_define("DapBreakpoint", {
  text = "●", -- a large dot; change as desired
  texthl = "DapBreakpointSign", -- the highlight group you just defined
  linehl = "", -- no full-line highlight
  numhl = "", -- no number-column highlight
})

local sev = vim.diagnostic.severity

local minimal_icons = {
  [sev.ERROR] = " ",
  [sev.WARN] = " ",
  [sev.INFO] = " ",
  [sev.HINT] = "󰌵 ",
}

local nerd_font_diagnostic_icons = {
  [sev.ERROR] = "󰅚 ",
  [sev.WARN] = "󰀪 ",

  [sev.INFO] = "󰋽 ",
  [sev.HINT] = "󰌶 ",
}

vim.diagnostic.config {
  underline = true,
  severity_sort = true,
  update_in_insert = false, -- less flicker
  signs = {
    text = vim.g.have_nerd_font and nerd_font_diagnostic_icons or minimal_icons,
  },
  float = {
    border = "rounded",
    source = true,
    format = function(diagnostic)
      local diagnostic_message = {
        [sev.ERROR] = diagnostic.message,
        [sev.WARN] = diagnostic.message,
        [sev.INFO] = diagnostic.message,
        [sev.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  linehl = {
    [sev.ERROR] = "DiagnosticErrorLine",
    [sev.WARN] = "DiagnosticWarnLine",
    [sev.INFO] = "DiagnosticInfoLine",
    [sev.HINT] = "DiagnosticHintLine",
  },
  jump = { float = true },
}

-- ═══════════════════════════════════════════════════════════
-- Diagnostics helpers
-- ═══════════════════════════════════════════════════════════

local NEXT = 1
local PREV = -1

local diagnostic_goto = function(count, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() vim.diagnostic.jump { count = count, float = true, severity = severity } end
end

local function toggle_virtual_lines()
  local new_value = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config { virtual_lines = new_value }
end

local function toggle_virtual_text()
  local new_value = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config { virtual_text = new_value }
end

-- ═══════════════════════════════════════════════════════════
-- Diagnostics Keymaps
-- ═══════════════════════════════════════════════════════════

local normal, leader = require("keymap").normal, require("keymap").leader

normal { "]d", diagnostic_goto(NEXT), "Next Diagnostic" }
normal { "[d", diagnostic_goto(PREV), "Prev Diagnostic" }
normal { "]e", diagnostic_goto(NEXT, sev.ERROR), "Next Error" }
normal { "[e", diagnostic_goto(PREV, sev.ERROR), "Prev Error" }
normal { "]w", diagnostic_goto(NEXT, sev.WARN), "Next Warning" }
normal { "[w", diagnostic_goto(PREV, sev.WARN), "Prev Warning" }

leader { "df", vim.diagnostic.open_float, "Line Diagnostics" }
leader { "dl", toggle_virtual_lines, "Toggle diagnostic virtual_lines" }
leader { "dt", toggle_virtual_text, "Toggle diagnostic virtual text" }
