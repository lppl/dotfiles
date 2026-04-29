local k = require("keymap")
local normal = k.normal
local visual = k.visual
local leader = k.leader
local insert = k.insert
local terminal = k.terminal
local cmd = k.cmd
local multi = k.multi
local group = k.group

-- ═══════════════════════════════════════════════════════════
-- TAB/BUFFER NAVIGATION (splitting and navigation)
-- ═══════════════════════════════════════════════════════════

-- Tab/Shift-Tab: Like browser tabs, feels natural
normal { "<Tab>", ":bnext<CR>", "Next buffer" }
normal { "<S-Tab>", ":bprevious<CR>", "Previous buffer" }

-- Quick switch to last edited file (super useful!)
leader { "bb", "<cmd>e #<cr>", "Switch to Other Buffer" }
leader { "`", "<cmd>e #<cr>", "Switch to Other Buffer" }

-- ═══════════════════════════════════════════════════════════
-- WINDOW MANAGEMENT (splitting and navigation)
-- ═══════════════════════════════════════════════════════════

-- Move between windows with Ctrl+hjkl (like tmux)
normal { "<C-h>", "<C-w>h", "Go to Left Window", remap = true }
normal { "<C-j>", "<C-w>j", "Go to Lower Window", remap = true }
normal { "<C-k>", "<C-w>k", "Go to Upper Window", remap = true }
normal { "<C-l>", "<C-w>l", "Go to Right Window", remap = true }

-- Resize windows with Ctrl+Shift+arrows (macOS friendly)
normal { "<C-S-Up>", "<cmd>resize +5<CR>" }
normal { "<C-S-Down>", "<cmd>resize -5<CR>" }
normal { "<C-S-Left>", "<cmd>vertical resize -5<CR>" }
normal { "<C-S-Right>", "<cmd>vertical resize +5<CR>" }

-- Window splitting
leader { "ww", "<C-W>p", "Other Window", remap = true }
leader { "wd", "<C-W>c", "Delete Window", remap = true }
leader { "w-", "<C-W>s", "Split Window Below", remap = true }
leader { "sh", "<C-W>s", "Split Window Below", remap = true }
leader { "w|", "<C-W>v", "Split Window Right", remap = true }
leader { "|", "<C-W>v", "Split Window Right", remap = true }
leader { "sv", "<C-W>v", "Split Window Right", remap = true }

-- ═══════════════════════════════════════════════════════════
-- SMART LINE MOVEMENT (the VSCode experience)
-- ═══════════════════════════════════════════════════════════

-- Smart j/k: moves by visual lines when no count, real lines with count
multi { "nx", "j", "v:count == 0 ? 'gj' : 'j'", "Down", expr = true }
multi { "nx", "<Down>", "v:count == 0 ? 'gj' : 'j'", "Down", expr = true }
multi { "nx", "k", "v:count == 0 ? 'gk' : 'k'", "Up", expr = true }
multi { "nx", "<Up>", "v:count == 0 ? 'gk' : 'k'", "Up", expr = true }

-- Move selected lines up/down
visual { "J", ":move '>+1<CR>gv=gv", "Move Block Down" }
visual { "K", ":move '<-2<CR>gv=gv", "Move Block Up" }

-- ═══════════════════════════════════════════════════════════
-- SEARCH & NAVIGATION
-- ═══════════════════════════════════════════════════════════

normal { "=0", "gg<S-v>G", "Select all" }
normal { "<esc>", "<cmd>noh<cr><esc>", "Escape and Clear hlsearch" }
leader { "ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><Cr>", "Redraw / Clear hlsearch / Diff Update" }

-- ═══════════════════════════════════════════════════════════
-- SMART TEXT EDITING
-- ═══════════════════════════════════════════════════════════

normal { "==", "ggVGgq", "Format file" }
visual { "=", "gq", "Format selection" }

visual { "<", "<gv", "Indent and stay in visual mode" }
visual { ">", ">gv", "Indent and stay in visual mode" }
visual { "p", '"_dP', "Paste witout replacing clipboRd with deleted text" }
normal { "<C-c>", ":%y+<CR>", "Copy whole file to clipboard" }

-- Smart undo break-points (create undo points at logical stops)
insert { ",", ",<c-g>u" }
insert { ".", ".<c-g>u" }
insert { ";", ";<c-g>u" }

-- Auto-close pairs (simple, no plugin needed)
insert { "`", "``<left>" }
insert { '"', '""<left>' }
insert { "(", "()<left>" }
insert { "[", "[]<left>" }
insert { "{", "{}<left>" }
insert { "<", "<><left>" }

-- Note: Single quotes commented out to avoid conflicts in some contexts
-- insert { "'", "''<left>")

-- ═══════════════════════════════════════════════════════════
-- FILE OPERATIONS
-- ═══════════════════════════════════════════════════════════

-- Save file (works in all modes)
multi { "inxs", "<C-s>", "<cmd>w<cr><esc>", "Save File" }

-- Create new file
leader { "fn", "<cmd>enew<cr>", "New File" }

-- Quit operations
leader { "qq", "<cmd>qa<cr>", "Quit All" }

-- ═══════════════════════════════════════════════════════════
-- DEVELOPMENT TOOLS
-- ═══════════════════════════════════════════════════════════

-- Commenting (add comment above/below current line)

leader { "co", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above" }
leader { "cb", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below" }

-- Quickfix and location lists

local function quickfix_list()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end

local function location_list()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end

leader { "xl", location_list, "Location List" }
leader { "xq", quickfix_list, "Quickfix List" }

vim.api.nvim_create_user_command("FoldMore", function() vim.wo.foldlevel = vim.wo.foldlevel + 1 end, {})

vim.api.nvim_create_user_command("FoldLess", function() vim.wo.foldlevel = math.max(0, vim.wo.foldlevel - 1) end, {})

normal { "[q", vim.cmd.cprev, "Previous Quickfix" }
normal { "]q", vim.cmd.cnext, "Next Quickfix" }

-- Inspection tools (useful for debugging highlights and treesitter)
leader { "ui", vim.show_pos, "Inspect Pos" }
leader { "uI", "<cmd>InspectTree<cr>", "Inspect Tree" }

-- Keyword program (K for help on word under cursor)
leader { "K", "<cmd>norm! K<cr>", "Keywordprg" }

-- ═══════════════════════════════════════════════════════════
-- TERMINAL INTEGRATION
-- ═══════════════════════════════════════════════════════════

-- Terminal mode navigation
terminal { "<esc><esc>", "<c-\\><c-n>", "Enter Normal Mode" }
terminal { "<C-h>", "<cmd>wincmd h<cr>", "Go to Left Window" }
terminal { "<C-j>", "<cmd>wincmd j<cr>", "Go to Lower Window" }
terminal { "<C-k>", "<cmd>wincmd k<cr>", "Go to Upper Window" }
terminal { "<C-l>", "<cmd>wincmd l<cr>", "Go to Right Window" }
terminal { "<C-/>", "<cmd>close<cr>", "Hide Terminal" }
terminal { "<c-_>", "<cmd>close<cr>", "which_key_ignore" }

-- ═══════════════════════════════════════════════════════════
-- TAB MANAGEMENT (when you need multiple workspaces)
-- ═══════════════════════════════════════════════════════════

group { "nv", "<leader><tab>", "[Tab]s" }
leader { "<tab><tab>", "<cmd>tabnew<cr>", "New Tab" }
leader { "<tab>p", "<cmd>tabprevious<cr>", "Previous Tab" }
leader { "<tab>n", "<cmd>tabnext<cr>", "Next Tab" }
leader { "<tab>f", "<cmd>tabfirst<cr>", "First Tab" }
leader { "<tab>l", "<cmd>tablast<cr>", "Last Tab" }
leader { "<tab>o", "<cmd>tabonly<cr>", "Close Other Tabs" }
leader { "<tab>d", "<cmd>tabclose<cr>", "Close Tab" }

-- ═══════════════════════════════════════════════════════════
-- FOLDING NAVIGATION (for code organization)
-- ═══════════════════════════════════════════════════════════

-- Close all folds except current one (great for focus)
normal { "zv", "zMzvzz", "Close all folds except the current one" }

-- Smart fold navigation (closes current, opens next/previous)
normal { "zj", "zcjzOzz", "Close current fold when open. Always open next fold." }
normal { "zk", "zckzOzz", "Close current fold when open. Always open previous fold." }

cmd { "kPlus", "FoldMore", "Fold More" }
cmd { "kMinus", "FoldLess", "Fold Less" }
cmd { "<leader>fj", "FoldMore", "Fold More" }
cmd { "<leader>fk", "FoldLess", "Fold Less" }

-- ═══════════════════════════════════════════════════════════
-- UTILITY SHORTCUTS
-- ═══════════════════════════════════════════════════════════

-- Toggle line wrapping
leader { "tw", "<cmd>set wrap!<CR>", "Toggle Wrap" }

-- Fix spelling (picks first suggestion)
normal { "z0", "1z=", "Fix word under cursor" }
