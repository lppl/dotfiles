vim.pack.add {
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    -- Last commit before nvim-treesitter have been archived
    -- @TODO check sometimes for alternatives
    version = "4916d6592ede8c07973490d9322f187e07dfefac",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    -- Look up
    version = "851e865342e5a4cb1ae23d31caf6e991e1c99f1e",
  },
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
  "odin",
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

map_query { "nxo", "af", select_textobject, "@function.outer" }
map_query { "nxo", "if", select_textobject, "@function.inner" }
map_query { "nxo", "ac", select_textobject, "@class.outer" }
map_query { "nxo", "ic", select_textobject, "@class.inner" }
map_query { "nxo", "aa", select_textobject, "@parameter.outer" }
map_query { "nxo", "ia", select_textobject, "@parameter.inner" }
map_query { "nxo", "ad", select_textobject, "@comment.outer" }
map_query { "nxo", "as", select_textobject, "@statement.outer" }
map_query { "nxo", "al", select_textobject, "@loop.outer" }
map_query { "nxo", "il", select_textobject, "@loop.inner" }
map_query { "nxo", "ai", select_textobject, "@conditional.outer" }
map_query { "nxo", "ii", select_textobject, "@conditional.inner" }
map_query { "nxo", "a=", select_textobject, "@assignment.rhs" }
map_query { "nxo", "i=", select_textobject, "@assignment.lhs" }
map_query { "nxo", "am", select_textobject, "@call.outer" }
map_query { "nxo", "im", select_textobject, "@call.inner" }

map_query { "nxo", "]f", move.goto_next_start, "@function.outer" }
map_query { "nxo", "[f", move.goto_previous_start, "@function.outer" }
map_query { "nxo", "]F", move.goto_next_end, "@function.outer" }
map_query { "nxo", "[F", move.goto_previous_end, "@function.outer" }

map_query { "nxo", "]]", move.goto_next_start, "@class.outer" }
map_query { "nxo", "[[", move.goto_previous_start, "@class.outer" }
map_query { "nxo", "]o", move.goto_next_start, { "@loop.inner ", "@loop.outer" } }
map_query {
  "nxo",
  "[o",
  move.goto_previous_start,
  { "@loop.inner ", "@loop.outer" },
}

multi {
  "nxo",
  ";",
  many.repeat_last_move_next,
  "Repeat last move next (with ts)",
}
multi {
  "nxo",
  ",",
  many.repeat_last_move_previous,
  "Repeat last move previous (with ts)",
}
multi { "nxo", "f", many.builtin_f_expr, "Repeat last f (with ts)", expr = true }
multi { "nxo", "F", many.builtin_F_expr, "Repeat last F (with ts)", expr = true }
multi { "nxo", "t", many.builtin_t_expr, "Repeat last t (with ts)", expr = true }
multi { "nxo", "T", many.builtin_T_expr, "Repeat last T (with ts)", expr = true }
