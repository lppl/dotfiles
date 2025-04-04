return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim"
  },
  init = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "eslint", "jsonls", "bashls", "terraformls" },
    })
  end
}
