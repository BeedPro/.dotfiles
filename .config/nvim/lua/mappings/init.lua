require "mappings.oil"
require "mappings.fzf-lua"
require "mappings.neogen"
require "mappings.dap"
require "mappings.conform"
require "mappings.neogit"
require "mappings.blink-cmp"

local map = vim.keymap.set

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "[D]iagnostic [S]how (loclist)" })
map("n", "<leader>da", vim.diagnostic.setqflist, { desc = "[D]iagnostic [A]ll (quickfix)" })
