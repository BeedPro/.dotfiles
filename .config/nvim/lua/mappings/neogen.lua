local map = vim.keymap.set

map("n", "<leader>cn", function()
  require("neogen").generate()
end, { desc = "[C]omments [N]eogen" })
