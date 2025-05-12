local ls = require("luasnip")
local lse = require("luasnip.extras")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require('luasnip.extras.fmt').fmt



-- local log = s(
--   "hello",
--   {
--     fmt(
--       "console.log({})",
--       c(1, {
--         t("{}"),
--         { fmt("{}") }
--       }),
--     ),
--     i(0)
--   },
--   {
--     selection = false,
--   }
-- );
--

local test_selection = s("test_selection", t("I am defined as selection true"), { selection = true })
local test_nonselection = s("test_nonselection", t("I am defined as selection false"), { selection = false })


local snip = s("snip", {
  -- t(fmt("local {name} = s(\"{name}\", {body})", { name = i(1), body = i(2) }, { repeat_duplicates = true })),
  t(fmt("{name} = {name}", { name = i(1) }, { repeat_duplicates = true })),
  i(0)
})

ls.add_snippets("all", { test_selection, test_nonselection });
ls.add_snippets("lua", { snip });
