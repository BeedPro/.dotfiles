require("mappings.oil")
require("mappings.telescope")
require("mappings.tmuxnav")

local map = vim.keymap.set

map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "P", '"+p')

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "General Saves file in all modes" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })


map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })


map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

map("n", "<leader>bk", "<cmd>bd<CR>", { desc = "Buffer Close buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Buffer Next tabbed buffer" })
map("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Buffer Previous tabbed buffer" })
map("n", "<leader>bl", "<cmd>buffer#<CR>", { desc = "Buffer Previous tabbed buffer" })
map("n", "<tab>", "<cmd>bnext<CR>", { desc = "Buffer Next tabbed buffer" })
map("n", "<S-tab>", "<cmd>bprev<CR>", { desc = "Buffer Previous tabbed buffer" })

map("n", "<C-d>", "<C-d>zz", { desc = "General Better page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "General Better page up" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

map("n", "<leader>cd", "<cmd> cd %:p:h <CR>", { desc = "General Change to current directory" })
