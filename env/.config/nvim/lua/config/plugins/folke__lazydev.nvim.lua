---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  lazy = false,
  opts = {
    library = {
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
