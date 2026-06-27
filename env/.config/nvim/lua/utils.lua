local M = {}

M.delete_non_current_buffers = function()
  local current = vim.api.nvim_get_current_buf()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if b ~= current and vim.bo[b].buflisted then vim.api.nvim_buf_delete(b, { force = true }) end
  end
  vim.cmd("only!")
end

return M
