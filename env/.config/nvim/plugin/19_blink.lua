vim.g.completion_mode = "blink"

vim.pack.add {
  { src = "https://github.com/Saghen/blink.cmp", version = "v1.10.2" },
  { src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.5.0" },
}

require("blink.cmp").setup {
  keymap = {
    ["<C-space>"] = { "show", "fallback" },

    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<Right>"] = { "select_next", "fallback" },
    ["<Left>"] = { "select_prev", "fallback" },

    ["<Tab>"] = { "select_and_accept", "fallback" },
    ["<Enter>"] = { "select_and_accept", "fallback" },
    ["<C-y>"] = { "select_and_accept", "fallback" },
    ["<Esc>"] = { "cancel", "fallback" },
    ["<C-e>"] = { "cancel", "fallback" },
  },
  appearance = { nerd_font_variant = "mono" },
  snippets = { preset = "luasnip" },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    ghost_text = { enabled = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    sorts = { "exact", "score", "sort_text" },
    implementation = "prefer_rust_with_warning",
  },
}
