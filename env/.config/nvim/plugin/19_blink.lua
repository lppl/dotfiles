vim.g.completion_mode = "blink"

vim.pack.add {
  { src = "https://github.com/Saghen/blink.cmp", version = "v1.10.2" },
  { src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.5.0" },
}

require("blink.cmp").setup {
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },
  snippets = { preset = "luasnip" },
  completion = { documentation = { auto_show = false } },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    sorts = { "exact", "score", "sort_text" },
    implementation = "prefer_rust_with_warning",
  },
}
