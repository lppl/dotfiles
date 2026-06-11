vim.pack.add {
  { src = "https://github.com/lewis6991/gitsigns.nvim", version = "25050e4ed39e628282831d4cbecb1850454ce915" },
}

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

local gitsigns = require("gitsigns")

local function next_chunk()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.nav_hunk("next")
  end
end

local function prev_chunk()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.nav_hunk("prev")
  end
end

gitsigns.setup {
  signs = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  blame_formatter = nil, -- Use default
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  on_attach = function(bufnr)
    -- Navigation
    normal { "]c", next_chunk, "Go to next chunk" }
    normal { "[c", prev_chunk, "Go to prev chunk" }

    -- Actions
    leader { "hs", gitsigns.stage_hunk, "Stage hunk" }
    leader { "hr", gitsigns.reset_hunk, "Reset hunk" }
    leader { "hS", gitsigns.stage_buffer, "Stage buffer" }
    leader { "hR", gitsigns.reset_buffer, "Reset buffer" }
    leader { "hp", gitsigns.preview_hunk, "Preview hunk" }
    leader { "hi", gitsigns.preview_hunk_inline, "Preview hunk inline" }
    leader { "hb", gitsigns.blame_line, "Blame" }
    leader { "hB", function() gitsigns.blame_line { full = true } end, "Blame" }
    leader { "hd", gitsigns.diffthis, "Diff this" }
    leader { "hD", function() gitsigns.diffthis("~") end, "Diff this" }
    leader { "hq", gitsigns.setqflist, "Set quicklist" }
    leader { "hQ", function() gitsigns.setqflist("all") end, "Set quicklist all" }

    leader {
      "hs",
      function() gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
      "Stage selection",
      mode = "v",
    }
    leader {
      "hr",
      function() gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
      "Reset selection",
      mode = "v",
    }

    -- Toggles
    leader { "ugb", gitsigns.toggle_current_line_blame, "Toggle gitsings blame" }
    leader { "ugw", gitsigns.toggle_word_diff, "Toggle gitsings word diff" }

    -- Text object
    -- map({ "o", "x" }, "ih", gitsigns.select_hunk)
  end,
}
