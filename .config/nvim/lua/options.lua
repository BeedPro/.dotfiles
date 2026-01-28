local opt = vim.opt
local o = vim.o
local g = vim.g

o.winborder = "single"
o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"

o.clipboard = ""
o.cursorline = true
o.cursorlineopt = "both"

o.expandtab = true
o.autoindent = true
o.smartindent = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2

o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 99
o.foldtext = "v:folddashes.substitute(getline(v:foldstart),'/\\*\\|\\*/\\|{{{\\d\\=','','g')"

o.updatetime = 250

opt.fillchars = { eob = " " }
opt.guicursor = ""
opt.shortmess:append "sI"
opt.wrap = false

opt.whichwrap:append "<>[]hl"

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
