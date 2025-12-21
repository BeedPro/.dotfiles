local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node

ls.add_snippets("htmldjango", {
	s("hello_dj_lua", {
		t("Hello World"),
	}),
})
