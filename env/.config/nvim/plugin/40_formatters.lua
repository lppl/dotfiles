vim.pack.add {
  { src = "https://github.com/stevearc/conform.nvim", version = "086a40dc7ed8242c03be9f47fbcee68699cc2395" },
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
    odin = { "odinfmt" },
  },
  formatters = {
    odinfmt = {
      command = "odinfmt",
      args = { "-stdin" },
      stdin = true,
    },
  },
}
