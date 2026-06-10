vim.pack.add {
  {
    src = "https://github.com/nvim-lua/plenary.nvim",
    version = "74b06c6c75e4eeb3108ec01852001636d85a932b",
  },
  {
    src = "https://github.com/olimorris/codecompanion.nvim",
    version = "680c445eb357c72129d175ea5d481aa9e92ae6a5",
  },
  {
    src = "https://github.com/github/copilot.vim.git",
    version = "a12fd5672110c8aa7e3c8419e28c96943ca179be",
  },
}

-- local model = "anthropic.claude-haiku-4-5-20251001-v1:0"
local model = "anthropic.claude-haiku-4-5-20251001-v1:0-with-thinking"
-- local model = "gpt-5.5-2026-04-24"
-- local model = "gemini-3-flash-preview"

require("codecompanion").setup {
  interactions = {
    chat = {
      adapter = "azure_openai",
      model = model,
    },
    inline = {
      adapter = "azure_openai",
      model = model,
    },
    cmd = {
      adapter = "azure_openai",
      model = model,
    },
    cli = {
      agent = "claude_code",
      agents = {
        claude_code = {
          cmd = "claude",
          args = {},
          description = "Claude Code CLI",
          provider = "terminal",
        },
      },
    },
  },
  adapters = {
    http = {
      azure_openai = function()
        -- if not vim.env.API_KEY then return nil end
        return require("codecompanion.adapters").extend("azure_openai", {
          env = {
            api_key = vim.env.AZURE_OPENAI_API_KEY,
            endpoint = vim.env.AZURE_OPENAI_ENDPOINT,
          },
          schema = {
            model = { default = "gpt-5-mini-2025-08-07" },
          },
        })
      end,
    },
    acp = {
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            ANTHROPIC_API_KEY = vim.env.CLAUDE_CODE_OAUTH_TOKEN,
          },
        })
      end,
    },
  },
}
