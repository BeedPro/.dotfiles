local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function id_from_filename()
  local name = vim.fn.expand "%:t:r"
  -- extract YYYYMMDDHHMM
  return name:match "^(%d%d%d%d%d%d%d%d%d%d%d%d)" or ""
end

local function title_from_filename()
  local filename = vim.fn.expand "%:t:r"

  -- remove leading YYYYMMDDHHMM + optional separator
  filename = filename:gsub("^%d%d%d%d%d%d%d%d%d%d%d%d[-_]?", "")

  filename = filename:gsub("_", " ")

  filename = filename:lower():gsub("(%f[%a]%a)", string.upper)

  return filename
end

ls.add_snippets("typst", {
  s("main", {
    t {
      '#import "preamble/style.typ": style',
      "#show: style",
      "",
      "",
    },
    t "ID = ",
    f(id_from_filename),
    t {
      "",
      "",
      ":main:",
    },
    i(1),
    t {
      "",
      "",
      "= ",
    },
    f(title_from_filename),
    t { "", "" },
    i(2),
    t { "", "", "= Links", "" },
    i(3),
    t { "", "", '#bibliography("sources.yaml")' },
  }),
})
