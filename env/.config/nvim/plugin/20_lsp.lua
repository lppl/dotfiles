vim.pack.add {
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
}

local function augroup(name) return vim.api.nvim_create_augroup("user_" .. name, { clear = true }) end
local completion = vim.g.completion_mode or "native" -- 'blink' or 'native'
local leader = require("keymap").leader
local normal = require("keymap").normal

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    local buf = args.buf

    if completion == "native" and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/inlayHint") then vim.lsp.inlay_hint.enable(true, { bufnr = buf }) end

    if client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, { bufnr = buf }, { style = "virtual" })
    end

    leader { "la", vim.lsp.buf.code_action, "Code Actions", buffer = buf }
    normal { "gr", vim.lsp.buf.rename, "Code Rename", buffer = buf }
    leader { "cf", vim.lsp.buf.format, "Code Format", buffer = buf, mode = "nv" }

    if client.server_capabilities["hoverProvider"] then normal { "K", vim.lsp.buf.hover, "Hover", buffer = buf } end
    if client.server_capabilities["definitionProvider"] then
      normal { "gd", vim.lsp.buf.definition, "Goto Definition", buffer = buf }
    end
    if client:supports_method("textDocument/references") then
      leader { "lr", vim.lsp.buf.references, "Show references", buffer = buf }
    end
    if client:supports_method("textDocument/documentSymbol") then
      leader { "ls", vim.lsp.buf.document_symbol, "Show symbols", buffer = buf }
    end
    if client:supports_method("textDocument/declaration") then
      leader { "lc", vim.lsp.buf.declaration, "Goto Declaration", buffer = buf }
    end
    if client:supports_method("textDocument/implementation") then
      leader { "li", vim.lsp.buf.implementation, "Goto Implementation", buffer = buf }
    end
    if client:supports_method("textDocument/typeDefinition") then
      leader { "lt", vim.lsp.buf.type_definition, "Goto Type Definition", buffer = buf }
    end
    if client.server_capabilities["signatureHelpProvider"] then
      leader { "lh", vim.lsp.buf.signature_help, "Signature help", buffer = buf }
    end
  end,
})

-- local ts_server = vim.g.lsp_typescript_server or "vtsls"
vim.lsp.enable {
  "lua_ls",
  "luacheck",
  "stylua",
}

-- Load Lsp on-demand, e.g: eslint is disable by default
-- e.g: We could enable eslint by set vim.g.lsp_on_demands = {"eslint"}
-- if vim.g.lsp_on_demands then
-- 	vim.lsp.enable(vim.g.lsp_on_demands)
-- end

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup {
  ensure_installed = {
    "luacheck",
    "stylua",
    "lua_ls",
  },
}
