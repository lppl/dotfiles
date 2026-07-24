vim.pack.add {
  { src = "https://github.com/stevearc/conform.nvim", version = "619363c30309d29ffa631e67c8183f2a72caa373" },
}

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("conform").setup {
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettier", stop_after_first = true },
    odin = { "odinfmt" },
  },
  formatters = {
    odinfmt = {
      command = vim.fn.expand("$HOME/.local/bin/odinfmt"),
      args = { "-stdin" },
      stdin = true,
    },
  },
}
