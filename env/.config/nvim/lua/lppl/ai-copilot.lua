local nmap = function(keys, func, desc)
  if desc then
    desc = 'AI Copilot: ' .. desc
  end
  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

return {
  "github/copilot.nvim",
  config = function()
    require("copilot").setup()
  end
}
