require "mappings.oil"
require "mappings.telescope"
require "mappings.neogen"
require "mappings.dap"
require "mappings.snacks"
require "mappings.conform"
require "mappings.typst"

local map = vim.keymap.set

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "[D]iagnostic [S]how (loclist)" })
map("n", "<leader>da", vim.diagnostic.setqflist, { desc = "[D]iagnostic [A]all (globallist)" })
