local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node

ls.add_snippets("all", {
  s("hello_world", {
    t "Hello, world!\\n",
  }),
})

ls.add_snippets("all", {
  s("checkhealth_luasnips", {
    t "Yes, luasnips works!",
  }),
})
