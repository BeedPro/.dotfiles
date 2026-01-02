require "mappings.telescope"
require "mappings.harpoon"
require "mappings.orgmode"
require "mappings.oil"
require "mappings.conform"
require "mappings.snacks"
require "mappings.tmuxnav"
require "mappings.trouble"
require "mappings.dap"
require "mappings.neotest"
require "mappings.neogen"
require "mappings.luasnip"

local map = vim.keymap.set

map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

map("i", "jk", "<ESC>", { desc = "General Return to Normal mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "General Saves file in all modes" })
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("n", "<leader>rr", ":.lua <cr>", { desc = "Lua Run the current line" })
map("v", "<leader>rr", ":lua <cr>", { desc = "Lua Run the selected lines" })

map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "P", '"+p')

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

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

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })

map("n", "g?", function()
  vim.diagnostic.open_float(nil, { border = "rounded", source = "always" })
end)

map("n", "K", function()
  vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
end, { desc = "Hover documentation" })
