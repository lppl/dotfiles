-- local util = require("lspconfig.util")

---@type vim.lsp.Config
return {
  filetypes = { "odin" },
  root_markers = {
    "ols.json",
  },
  cmd = { vim.fn.expand("~/.local/bin/ols") },
  settings = {
    odin_command = "odin",
  },
}
