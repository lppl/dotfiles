-- local fd = vim.loop.fs_scandir(vim.fn.stdpath('config') .. '/lua/user/')
--
-- for name in function() return vim.loop.fs_scandir_next(fd) end
-- do
--   require('user.' .. name:gsub('.lua\z', ''))
-- end
--
local base = vim.fn.stdpath('config') .. '/lua/config/user/';
local files = vim.fn.readdir(base) or {};
for _, name in ipairs(files) do if name:match('%.lua$') then pcall(dofile, base .. name) end end
