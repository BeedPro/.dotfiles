local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("typst", {
  s("zn", {
    t {
      '#import "style.typ": style',
      "#show: style",
      "",
      "= ",
    },
    i(1, "Title"),
    t {
      "",
      "",
    },
    i(2),
  }),
})
