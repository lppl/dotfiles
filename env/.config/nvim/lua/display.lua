local M = {}

M.get_terminal_info = function()
  local width = vim.o.columns
  local height = vim.o.lines
  local orientation = width > (height * 2) and "landscape" or "portrait"
  local area = width * height
  local size
  if area < 1600 * 1000 then
    size = "small"
  elseif area < 1920 * 1440 then
    size = "medium"
  else
    size = "large"
  end
  return {
    orientation = orientation,
    size = size,
    width = width,
    height = height,
  }
end

return M
