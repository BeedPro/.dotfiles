local map = vim.keymap.set

map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "P", '"+p')

require("mappings.oil")
