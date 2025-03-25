return {
  'neovim/nvim-lspconfig',
  dependencies = {
    "folke/lazydev.nvim",
    "Saghen/blink.cmp",
    "williamboman/mason-lspconfig.nvim"
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup({ capabilities = capabilities })
  end
}
