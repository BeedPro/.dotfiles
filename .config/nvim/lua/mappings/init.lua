require "mappings.oil"
require "mappings.telescope"
require "mappings.neogen"
require "mappings.dap"
require "mappings.conform"
require "mappings.neogit"
require "mappings.whichkey"
require "mappings.blink"

local map = vim.keymap.set

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "[D]iagnostic [S]how (loclist)" })
map("n", "<leader>da", vim.diagnostic.setqflist, { desc = "[D]iagnostic [A]all (globallist)" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: normal mode" })
