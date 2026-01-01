require("mappings.oil")
require("mappings.telescope")
require("mappings.tmuxnav")

local map = vim.keymap.set

map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "P", '"+p')

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })
