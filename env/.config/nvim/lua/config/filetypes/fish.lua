vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fish',
  callback = function()
    require("notify")("My fish is alive")
    vim.lsp.start({
      name = 'fish-lsp',
      cmd = { 'fish-lsp', 'start' },
      cmd_env = { fish_lsp_show_client_popups = false },
    })
  end,
})
