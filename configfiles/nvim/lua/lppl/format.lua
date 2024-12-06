return {
  "elentok/format-on-save.nvim",
  config = function()
    local format_on_save = require("format-on-save")
    local vim_notify = require("format-on-save.error-notifiers.vim-notify")
    local formatters = require("format-on-save.formatters")

    format_on_save.setup({
      error_notifier     = vim_notify,
      fallback_formatter = {
        formatters.remove_trailing_whitespace,
        formatters.remove_trailing_newlines,
        formatters.lsp,
      },
      formatter_by_ft    = {
        css = formatters.lsp,
        html = formatters.prettierd,
        javascript = formatters.prettierd,
        json = formatters.lsp,
        lua = formatters.lsp,
        markdown = formatters.prettierd,
        scss = formatters.lsp,
        terraform = formatters.lsp,
        typescript = formatters.prettierd,
        typescriptreact = formatters.prettierd,
        yaml = formatters.lsp,
      }
    })
  end
}
