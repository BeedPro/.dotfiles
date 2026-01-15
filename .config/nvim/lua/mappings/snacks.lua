local map = vim.keymap.set
local snacks = require "snacks"

map("n", "<leader>n", function()
  snacks.notifier.show_history()
end, { desc = "[N]otification History" })

map("n", "<leader>un", function()
  snacks.notifier.hide()
end, { desc = "[U][N]otifications" })
