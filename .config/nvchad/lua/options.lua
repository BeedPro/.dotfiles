require "nvchad.options"

local g = vim.g
local o = vim.o
o.clipboard = ""
o.relativenumber = true
o.cursorlineopt = "both"
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 99
o.foldtext = "v:folddashes.substitute(getline(v:foldstart),'/\\*\\|\\*/\\|{{{\\d\\=','','g')"
