require "mappings.oil"
require "mappings.telescope"
require "mappings.harpoon"
require "mappings.tmuxnav"
require "mappings.mason"
require "mappings.neogen"
require "mappings.dap"
require "mappings.snacks"
require "mappings.neotest"
require "mappings.nvzone"
require "mappings.conform"

local map = vim.keymap.set

map("n", "<C-Up>", ":resize +2<CR>", { desc = "[W]indow [H]eight +" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "[W]indow [H]eight -" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "[W]indow [W]idth -" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "[W]indow [W]idth +" })

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "[S]ave [F]ile" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to clipboard" })
map({ "n", "v" }, "P", '"+p', { desc = "[P]aste from clipboard" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "[C]lear [H]ighlights" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "[C]opy [A]ll" })

map("n", "<leader>/", "gcc", { desc = "[C]omment [T]oggle", remap = true })
map("v", "<leader>/", "gc", { desc = "[C]omment [T]oggle", remap = true })

map("n", "<leader>bk", "<cmd>bd<CR>", { desc = "[B]uffer [K]ill" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "[B]uffer [N]ext" })
map("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "[B]uffer [P]revious" })
map("n", "<leader>bl", "<cmd>buffer#<CR>", { desc = "[B]uffer [L]ast" })

map("n", "<tab>", "<cmd>bnext<CR>", { desc = "[B]uffer [N]ext" })
map("n", "<S-tab>", "<cmd>bprev<CR>", { desc = "[B]uffer [P]revious" })

map("n", "<leader>cd", "<cmd>cd %:p:h<CR>", { desc = "[C]hange [D]irectory" })

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "[D]iagnostic [S]how (loclist)" })

map("n", "g?", function()
  vim.diagnostic.open_float(nil, { border = "rounded", source = "always" })
end, { desc = "[D]iagnostic [H]over" })
