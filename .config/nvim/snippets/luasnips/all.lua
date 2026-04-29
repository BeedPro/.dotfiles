local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

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

ls.add_snippets("all", {
  s("dtid", {
    f(function()
      return os.date "%Y%m%d%H%M%S"
    end),
  }),
})
