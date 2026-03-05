local map = vim.keymap.set

local snacks = require "snacks"

map("n", "<leader>n", function()
  snacks.notifier.show_history()
end, { desc = "[N]otification History" })

map("n", "<leader>un", function()
  snacks.notifier.hide()
end, { desc = "[U][N]otifications" })

map("n", "<leader>gi", function()
  snacks.picker.gh_issue()
end, { desc = "[G]itHub [I]ssues (open)" })

map("n", "<leader>gI", function()
  snacks.picker.gh_issue { state = "all" }
end, { desc = "[G]itHub [I]ssues (all)" })

map("n", "<leader>gp", function()
  snacks.picker.gh_pr()
end, { desc = "[G]itHub [P]ull Requests (open)" })

map("n", "<leader>gP", function()
  snacks.picker.gh_pr { state = "all" }
end, { desc = "[G]itHub [P]ull Requests (all)" })
