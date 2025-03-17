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
    "github/copilot.vim",
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  },
  config = function()
    require("codecompanion").setup({
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
          provider = "telescope",               -- default|telescope|mini_pick
          opts = {
            show_default_actions = true,        -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
      },
    })
    nmap("<leader>cl", "<cmd>CodeCompanionActions<cr>", "Code Companion Actions")
    nmap("<leader>cc", "<cmd>CodeCompanionChat<cr>", "Code Companion Chat")
    nmap("<leader>cj", "<cmd>CodeCompanionChat Add<cr>", "Code Companion Add to Chat")
  end
}
