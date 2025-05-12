vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lppl-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('<leader>lr', vim.lsp.buf.rename, 'Rename')
    map('<leader>la', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
    -- map('grr', require('telescope.builtin').lsp_references, '[G]oto References')
    -- map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    -- map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    -- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
    -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
      end,
    })


    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    --   map('<leader>th', function()
    --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    --   end, '[T]oggle Inlay [H]ints')
    -- end
  end
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
-- vim.diagnostic.config {
--   severity_sort = true,
--   float = { border = 'rounded', source = 'if_many' },
--   underline = { severity = vim.diagnostic.severity.ERROR },
--   signs = vim.g.have_nerd_font and {
--     text = {
--       [vim.diagnostic.severity.ERROR] = '󰅚 ',
--       [vim.diagnostic.severity.WARN] = '󰀪 ',
--       [vim.diagnostic.severity.INFO] = '󰋽 ',
--       [vim.diagnostic.severity.HINT] = '󰌶 ',
--     },
--   } or {},
--   virtual_text = {
--     source = 'if_many',
--     spacing = 2,
--     format = function(diagnostic)
--       local diagnostic_message = {
--         [vim.diagnostic.severity.ERROR] = diagnostic.message,
--         [vim.diagnostic.severity.WARN] = diagnostic.message,
--         [vim.diagnostic.severity.INFO] = diagnostic.message,
--         [vim.diagnostic.severity.HINT] = diagnostic.message,
--       }
--       return diagnostic_message[diagnostic.severity]
--     end,
--   },
-- }

---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    "folke/lazydev.nvim",
    "Saghen/blink.cmp",
    {
      "williamboman/mason-lspconfig.nvim",
      version = "^1.0.0",
    },
    {
      "williamboman/mason.nvim",
      version = "^1.0.0",
      config = function()
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
            }
          }
        })
      end
    }
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = require('lspconfig')

    local servers = {}
    local default_server = {
      capabilities = capabilities,
      lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }
    }

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "eslint", "jsonls", "bashls", "terraformls" },
      handlers = {
        function(server_name)
          local server = servers[server_name] or default_server
          lspconfig[server_name].setup(server)
        end,
      },
    })
  end
}
