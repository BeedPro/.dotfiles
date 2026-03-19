local map = vim.keymap.set

map("n", "<leader>gg", function()
  require("neogit").open()
end, { desc = "Open Neo[g]it UI" })
