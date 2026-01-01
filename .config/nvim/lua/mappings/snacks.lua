local map = vim.keymap.set
local snacks = require "snacks"

map("n", "<leader>gl", function()
  ---@diagnostic disable-next-line: undefined-field
  snacks.lazygit.log()
end, { desc = "Snacks Lazygit Log (cwd)" })

map("n", "<leader>gf", function()
  ---@diagnostic disable-next-line: undefined-field
  snacks.lazygit.log_file()
end, { desc = "Snacks Lazygit Current File History" })

map("n", "<leader>n", function()
  snacks.notifier.show_history()
end, { desc = "Snacks Notification History" })

map("n", "<leader>un", function()
  snacks.notifier.hide()
end, { desc = "Snacks Dismiss All Notifications" })
