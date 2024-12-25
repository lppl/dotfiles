local nmap = function(keys, func, desc)
  if desc then
    desc = 'AI: ' .. desc
  end
  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  },
  config = function()
    require("codecompanion").setup()
    nmap("<leader>cl", "<cmd>CodeCompanionActions<cr>", "Code Companion Actions")
    nmap("<leader>cc", "<cmd>CodeCompanionChat<cr>", "Code Companion Chat")
    nmap("<leader>cj", "<cmd>CodeCompanionChat Add<cr>", "Code Companion Add to Chat")
  end
}
