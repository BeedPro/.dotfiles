local map = vim.keymap.set
local snacks = require "snacks"

map("n", "<leader>gl", function()
  snacks.lazygit.log()
end, { desc = "Lazy[G]it [L]og" })

map("n", "<leader>gf", function()
  snacks.lazygit.log_file()
end, { desc = "Lazy[g]it Log [F]ile" })

map("n", "<leader>n", function()
  snacks.notifier.show_history()
end, { desc = "[N]otification History" })

map("n", "<leader>un", function()
  snacks.notifier.hide()
end, { desc = "[U][N]otifications" })
