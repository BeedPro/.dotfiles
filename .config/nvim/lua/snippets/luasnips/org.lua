local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("org", {
  s("link", {
    t "[[",
    i(1, "LINK"),
    t "][",
    i(2, "DESCRIPTION"),
    t "]]",
  }),
})
