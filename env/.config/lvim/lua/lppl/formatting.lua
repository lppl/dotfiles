lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.lua", "*.py" }

local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { name = "black" },
--   {
--     name = "prettierd",
--     filetypes = {
--       "markdown",
--       "typescript",
--       "typescriptreact"
--     },
--   },
-- }
