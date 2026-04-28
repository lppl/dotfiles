vim.pack.add {
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
}

-- ═══════════════════════════════════════════════════════════
-- Treesitter Setup
-- ═══════════════════════════════════════════════════════════

vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

local languages = {
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "markdown",
  "yaml",
  "json",
  "lua",
  "vim",
  "vimdoc",
  "rust",
  "gdscript",
}

require("nvim-treesitter").setup {
  ensure_installed = languages,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true, disable = { "python" } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-Space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<a-space>",
    },
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = languages,
  callback = function()
    print("Treesitter start")
    vim.treesitter.start()
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- ═══════════════════════════════════════════════════════════
-- Textobjects Setup
-- ═══════════════════════════════════════════════════════════

require("nvim-treesitter-textobjects").setup {
  select = {
    enable = true,
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v", -- charwise
      ["@function.outer"] = "V", -- linewise
      ["@class.outer"] = "<c-v>", -- blockwise
    },
    include_surrounding_whitespace = false,
  },
  move = {
    enable = true,
    set_jumps = true,
  },
  swap = {
    enable = true,
  },
}

-- ═══════════════════════════════════════════════════════════
-- Textobjects Keymap
-- ═══════════════════════════════════════════════════════════

local multi = require("keymap").multi
local map_query = require("keymap").map_query

local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
local move = require("nvim-treesitter-textobjects.move")
local many = require("nvim-treesitter-textobjects.repeatable_move")

map_query { "xo", "af", select_textobject, "@function.outer" }
map_query { "xo", "if", select_textobject, "@function.inner" }
map_query { "xo", "ac", select_textobject, "@class.outer" }
map_query { "xo", "ic", select_textobject, "@class.inner" }
map_query { "xo", "aa", select_textobject, "@parameter.outer" }
map_query { "xo", "ia", select_textobject, "@parameter.inner" }
map_query { "xo", "ad", select_textobject, "@comment.outer" }
map_query { "xo", "as", select_textobject, "@statement.outer" }
map_query { "xo", "al", select_textobject, "@loop.outer" }
map_query { "xo", "il", select_textobject, "@loop.inner" }
map_query { "xo", "ai", select_textobject, "@conditional.outer" }
map_query { "xo", "ii", select_textobject, "@conditional.inner" }
map_query { "xo", "a=", select_textobject, "@assignment.rhs" }
map_query { "xo", "i=", select_textobject, "@assignment.lhs" }
map_query { "xo", "a(", select_textobject, "@call.outer" }
map_query { "xo", "i(", select_textobject, "@call.inner" }

map_query { "nxo", "]f", move.goto_next_start, "@function.outer" }
map_query { "nxo", "[f", move.goto_previous_start, "@function.outer" }
map_query { "nxo", "]F", move.goto_next_end, "@function.outer" }
map_query { "nxo", "[F", move.goto_previous_end, "@function.outer" }

map_query { "nxo", "]]", move.goto_next_start, "@class.outer" }
map_query { "nxo", "[[", move.goto_previous_start, "@class.outer" }
map_query { "nxo", "]o", move.goto_next_start, { "@loop.inner", "@loop.outer" } }
map_query { "nxo", "[o", move.goto_previous_start, { "@loop.inner", "@loop.outer" } }

multi { "nxo", ";", many.repeat_last_move_next, "Repeat last move next (with ts)" }
multi { "nxo", ",", many.repeat_last_move_previous, "Repeat last move previous (with ts)" }
multi { "nxo", "f", many.builtin_f_expr, "Repeat last f (with ts)", expr = true }
multi { "nxo", "F", many.builtin_F_expr, "Repeat last F (with ts)", expr = true }
multi { "nxo", "t", many.builtin_t_expr, "Repeat last t (with ts)", expr = true }
multi { "nxo", "T", many.builtin_T_expr, "Repeat last T (with ts)", expr = true }
