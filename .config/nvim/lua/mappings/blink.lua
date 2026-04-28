local map = vim.keymap.set

map("i", "<C-x><C-o>", function()
  require("blink.cmp").show()
end, { desc = "Blink: show completion" })
