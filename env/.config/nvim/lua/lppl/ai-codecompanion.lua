local nmap = function(keys, func, desc)
  if desc then
    desc = 'AI: ' .. desc
  end
  vim.keymap.set('n', keys, func, { desc = desc })
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
      prompt_library = {
        ["Duck"] = {
          strategy = "chat",
          description = "Prompting duck",
          prompts = {
            {
              role = "system",
              content =
              "You are an experienced developer. You Be direct. Ask me questions.  Give me short answers. Be honest. Less is more. Write ansers like Uncle Bob or Martin Fowler would. ",
            },
          },
        }
      }
    })
    nmap("<leader>cl", "<cmd>CodeCompanionActions<cr>", "Action Palette")
    nmap("<leader>cc", "<cmd>CodeCompanionChat<cr>", "Code Companion Chat")
    nmap("<leader>cj", "<cmd>CodeCompanionChat Add<cr>", "Code Companion Add to Chat")
    nmap("<leader>p", "<cmd>CodeCompanionActions<cr>", "Action Palette")
  end
}
