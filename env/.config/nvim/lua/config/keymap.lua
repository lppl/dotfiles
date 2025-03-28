local ws = require "which-key"

ws.add({
  { "<c-left>",  "<cmd>vertical resize -3<cr>",   desc = "Resize left",  mode = "nv" },
  { "<c-right>", "<cmd>vertical resize +3<cr>",   desc = "Resize right", mode = "nv" },
  { "<c-up>",    "<cmd>horizontal resize -3<cr>", desc = "Resize right", mode = "nv" },
  { "<c-down>",  "<cmd>horizontal resize +3<cr>", desc = "Resize right", mode = "nv" },
})



-- When line wrapping is enabled, the 'j' and 'k' keys should navigate by visual
-- lines instead of physical lines. This behavior applies only when there is no
-- count prefix, which would indicate a different intention.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
