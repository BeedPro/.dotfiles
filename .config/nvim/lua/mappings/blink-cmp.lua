local map = vim.keymap.set

map("i", "<C-x><C-o>", function()
  require("blink.cmp").show()
end, { desc = "Blink: show completion" })

map("i", "<C-x><C-s>", function()
  require("blink.cmp").show { providers = { "spell" } }
end, { desc = "Blink: show spell completion" })
