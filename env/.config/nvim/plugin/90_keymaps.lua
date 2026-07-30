local k = require("keymap")
local normal = k.normal
local visual = k.visual
local leader = k.leader
local insert = k.insert
local option = k.option
local toggle = k.toggle
local terminal = k.terminal
local cmd = k.cmd
local cmd_leader = k.cmd_leader
local multi = k.multi
local group = k.group

local utils = require("utils")

-- ═══════════════════════════════════════════════════════════
-- TAB/BUFFER NAVIGATION (splitting and navigation)
-- ═══════════════════════════════════════════════════════════

-- Tab/Shift-Tab: Like browser tabs, feels natural
normal { "<Tab>", ":bnext<CR>", "Next buffer" }
normal { "<S-Tab>", ":bprevious<CR>", "Previous buffer" }
normal { "<F4>", "<CMD>only<CR>", "Close non current splits" }
normal { "<F16>", utils.delete_non_current_buffers, "Close con current buffers" }

-- Quick switch to last edited file (super useful!)
leader { "bb", "<cmd>e #<cr>", "Switch to Other Buffer" }
leader { "`", "<cmd>e #<cr>", "Switch to Other Buffer" }

-- ═══════════════════════════════════════════════════════════
-- WINDOW MANAGEMENT (splitting and navigation)
-- ═══════════════════════════════════════════════════════════

-- Move between windows with Ctrl+hjkl (like tmux)
cmd { "<C-h>", "TmuxNavigateLeft", "Go to Left Window", remap = true }
cmd { "<C-j>", "TmuxNavigateDown", "Go to Lower Window", remap = true }
cmd { "<C-k>", "TmuxNavigateUp", "Go to Upper Window", remap = true }
cmd { "<C-l>", "TmuxNavigateRight", "Go to Right Window", remap = true }

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
visual { "p", '"_dP', "Paste without replacing clipboRd with deleted text" }
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
leader { "qq", "<cmd>SessionQuit<cr>", "Quit All" }

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
normal { "<C-PageUp>", "<cmd>tabnext<cr>", "Next Tab" }
normal { "<C-PageDown>", "<cmd>tabprevious<cr>", "Previous Tab" }

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

-- ═══════════════════════════════════════════════════════════
-- CODE NAVIGATION
-- ═══════════════════════════════════════════════════════════

local flash = require("flash")
multi { "nxo", "<C-CR>", flash.jump, "Flash Jump" }
multi { "nxo", "gp", flash.treesitter, "Flash Treesitter" }
multi { "xo", "gs", flash.treesitter_search, "Flash Treesitter Search" }
multi { "c", "<C-CR>", flash.toggle, "Flash Toggle" }

cmd_leader { "xx", "Trouble diagnostics toggle", "Diagnostics (Trouble)" }
cmd_leader { "xX", "Trouble diagnostics toggle filter.buf=0", "Buffer Diagnostics (Trouble)" }
cmd_leader { "cs", "Trouble symbols toggle focus=false", "Symbols (Trouble)" }
cmd_leader { "cll", "Trouble lsp toggle focus=false win.position=right", "LSP Definitions / references / ... (Trouble)" }
cmd_leader { "xQ", "Trouble qflist toggle", "Quickfix List (Trouble)" }
cmd_leader { "xL", "Trouble loclist toggle", "Location List (Trouble)" }

-- ═══════════════════════════════════════════════════════════
-- Toggles
-- ═══════════════════════════════════════════════════════════
option { "<leader>us", "spell", "Spelling" }
option { "<leader>uw", "wrap", "Wrap" }
option { "<leader>ul", "relativenumber", "Relative Number" }

option { "<leader>uc", "conceallevel", off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
option { "<leader>ub", "background", "Dark Background", off = "light", on = "dark" }

local toggles = Snacks.toggle
toggle { "<leader>ud", toggles.diagnostics() }
toggle { "<leader>un", toggles.line_number() }
toggle { "<leader>ut", toggles.treesitter() }
toggle { "<leader>uh", toggles.inlay_hints() }
toggle { "<leader>ui", toggles.indent() }
toggle { "<leader>ud", toggles.dim() }

-- ═══════════════════════════════════════════════════════════
-- File pickers
-- ═══════════════════════════════════════════════════════════

local snack = Snacks
local picker = Snacks.picker

local function pick_config() picker.files { cwd = vim.fn.stdpath("config") } end

leader { "<space>", picker.smart, "Smart Find Files" }
leader { "b", picker.buffers, "Buffers" }
leader { "/", picker.grep, "Grep" }
leader { ":", picker.command_history, "Command History" }
leader { "n", picker.notifications, "Notification History" }
leader { "e", snack.explorer.open, "File Explorer" }

-- find
leader { "fb", picker.buffers, "Buffers" }
leader { "fc", pick_config, "Find Config File" }
leader { "ff", picker.files, "Find Files" }
leader { "fg", picker.git_files, "Find Git Files" }
leader { "fp", picker.projects, "Projects" }
leader { "fr", picker.recent, "Recent" }

-- git
leader { "gg", snack.lazygit.open, "Lazygit" }
leader { "gib", picker.git_branches, "Git Branches" }
leader { "gil", picker.git_log, "Git Log" }
leader { "giL", picker.git_log_line, "Git Log Line" }
leader { "gis", picker.git_status, "Git Status" }
leader { "giS", picker.git_stash, "Git Stash" }
leader { "gid", picker.git_diff, "Git Diff (Hunks)" }
leader { "gif", picker.git_log_file, "Git Log File" }

leader { "gio", "<cmd>DiffviewOpen<cr>", "Git open diffview" }
leader { "gic", "<cmd>DiffviewClose<cr>", "Git close diffview" }
leader { "gih", "<cmd>DiffviewFileHistory %<cr>", "Git current file history" }
leader { "giH", "<cmd>DiffviewFileHistory<cr>", "Git file history" }

-- Grep
leader { "sb", picker.lines, "Buffer Lines" }
leader { "sB", picker.grep_buffers, "Grep Open Buffers" }
leader { "sg", picker.grep, "Grep" }
leader { "sw", picker.grep_word, "Visual selection or word", mode = "nx" }

-- search
leader { 's"', picker.registers, "Registers" }
leader { "s/", picker.search_history, "Search History" }
leader { "sa", picker.autocmds, "Autocmds" }
leader { "sb", picker.lines, "Buffer Lines" }
leader { "sc", picker.command_history, "Command History" }
leader { "sC", picker.commands, "Commands" }
leader { "sd", picker.diagnostics, "Diagnostics" }
leader { "sD", picker.diagnostics_buffer, "Buffer Diagnostics" }
leader { "sh", picker.help, "Help Pages" }
leader { "sH", picker.highlights, "Highlights" }
leader { "si", picker.icons, "Icons" }
leader { "sj", picker.jumps, "Jumps" }
leader { "sk", picker.keymaps, "Keymaps" }
leader { "sl", picker.loclist, "Location List" }
leader { "sm", picker.marks, "Marks" }
leader { "sM", picker.man, "Man Pages" }
leader { "sp", picker.lazy, "Search for Plugin Spec" }
leader { "sq", picker.qflist, "Quickfix List" }
leader { "sR", picker.resume, "Resume" }
leader { "su", picker.undo, "Undo History" }
leader { "uC", picker.colorschemes, "Colorschemes" }

-- LSP
leader { "ld", picker.lsp_definitions, "Goto Definition" }
leader { "lf", picker.lsp_declarations, "Goto Declaration" }
leader { "lr", picker.lsp_references, "References" }
leader { "li", picker.lsp_implementations, "Goto Implementation" }
leader { "lt", picker.lsp_type_definitions, "Goto T[y]pe Definition" }
leader { "ss", picker.lsp_symbols, "LSP Symbols" }
leader { "sS", picker.lsp_workspace_symbols, "LSP Workspace Symbols" }

-- Other
leader { ".", snack.scratch.open, "Toggle Scratch Buffer" }
leader { "S", snack.scratch.select, "Select Scratch Buffer" }
leader { "z", snack.zen.zen, "Toggle Zen Mode" }
leader { "Z", snack.zen.zoom, "Toggle Zoom" }
leader { "n", snack.notifier.show_history, "Notification History" }
leader { "un", snack.notifier.hide, "Dismiss All Notifications" }
leader { "t", snack.terminal.toggle, "Toggle Terminal" }

local function cc_chat(a, b)
  return function() require("codecompanion").chat(a, b) end
end

local function cc_cli(a, b)
  return function() require("codecompanion").cli(a, b) end
end

local function cc_cmd(a, b)
  return function() require("codecompanion").cmd(a, b) end
end

group { "nv", "<leader>ch", "Chat, Code Companion" }
leader { "chi", cc_chat { prompt = true }, "Code companion CHAT", mode = "nv" }
leader { "chf", cc_chat { focus = true }, "Code companion CHAT", mode = "nv" }
leader { "cha", cc_chat("#{this}", { focus = false }), "Code companion CHAT ", mode = "nv" }
leader {
  "chd",
  cc_chat("#{diagnostics} Fix diagnostics. Explain if not possible.", { focus = true, submit = true }),
  "Code companion CHAT ",
  mode = "nv",
}
leader {
  "cht",
  cc_chat("#{terminal} Sharing the output from the terminal. Can you fix it?", { focus = false, submit = true }),
  "Code companion CHAT ",
  mode = "nv",
}

group { "nv", "<leader>cl", "CLI, Code Companion" }
leader { "cli", cc_cli { prompt = true }, "Code companion CLI", mode = "nv" }
leader { "clf", cc_cli { focus = true }, "CC: Focus CLI", mode = "nv" }
leader { "clat", cc_cli("#{this}", { focus = false }), "CC: CLI add this ", mode = "nv" }
leader { "clad", cc_cli("#{diagnostics}", { focus = false }), "CC: CLI add diagnostics ", mode = "nv" }
leader {
  "clt",
  cc_cli("#{terminal} Sharing the output from the terminal. Can you fix it?", { focus = false, submit = true }),
  "CC: CLI share and fix terminal",
  mode = "nv",
}
leader {
  "cld",
  cc_cli("#{diagnostics} Fix diagnostics. Explain if not possible.", { focus = true, submit = true }),
  "CC: CLI Explain diagnostics",
  mode = "nv",
}

group { "nv", "<leader>cm", "CMD, Code Companion" }
leader { "cmi", cc_cmd { prompt = true }, "Code companion CMD", mode = "nv" }
leader { "cmf", cc_cmd { focus = true }, "CC: Focus CMD", mode = "nv" }
leader { "cmat", cc_cmd("#{this}", { focus = false }), "CC: CMD add this ", mode = "nv" }
leader { "cmad", cc_cmd("#{diagnostics}", { focus = false }), "CC: CMD add diagnostics ", mode = "nv" }
leader {
  "cmt",
  cc_cmd("#{terminal} Fix terminal output", { focus = false, submit = true }),
  "CC: CMD share and fix",
  mode = "nv",
}
leader {
  "cmd",
  cc_cmd("#{diagnostics} Fix diagnostics. Explain if not possible.", { focus = true, submit = true }),
  "CC: CMD Explain diagnostics",
  mode = "nv",
}

-- vim.keymap.set({ "n", "v" }, "<LocalLeader>cp", function()
--   return require("codecompanion").cli({ prompt = true })
-- end, { desc = "Prompt the CLI agent" })
--
--
--

-- ═══════════════════════════════════════════════════════════
-- Script runner
-- ═══════════════════════════════════════════════════════════
local runner = require("script_runner")
normal { "<F9>", runner.rerun, "Rerun last script" }
normal { "<F10>", runner.pick_script, "Pick script to run" }
normal { "<F11>", runner.toggle_output, "Toggle output" }
normal { "<F12>", runner.cycle_scripts, "Cycle script output buffers" }
