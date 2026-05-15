vim.pack.add {
  {
    src = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    version = "629eb9533ec989d9d5c6cab8f3ad5372422c24e0",
  },
}

require("render-markdown").setup {
  completions = { lsp = { enabled = true } },
}
