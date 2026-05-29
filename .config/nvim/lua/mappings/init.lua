require "mappings.oil"
require "mappings.fzf-lua"
require "mappings.neogen"
require "mappings.dap"
require "mappings.conform"
require "mappings.neogit"
require "mappings.blink-cmp"

local map = vim.keymap.set

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Show diagnostics in location list" })
map("n", "<leader>da", vim.diagnostic.setqflist, { desc = "Show all diagnostics in quickfix" })
