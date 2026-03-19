local map = vim.keymap.set
local neogit = require "neogit"

map("n", "<leader>gg", neogit.open, { desc = "Open Neo[g]it UI" })
