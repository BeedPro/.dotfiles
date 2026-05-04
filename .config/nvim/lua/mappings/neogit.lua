local map = vim.keymap.set

map("n", "<leader>gg", function()
  require("neogit").open()
end, { desc = "[G]it Open Neo[G]it" })
