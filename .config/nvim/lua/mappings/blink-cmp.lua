local map = vim.keymap.set

map("i", "<C-x><C-o>", function()
  require("blink.cmp").show()
end, { desc = "[B]link Show [C]ompletion" })

map("i", "<C-x><C-s>", function()
  require("blink.cmp").show { providers = { "spell" } }
end, { desc = "[B]link Show [S]pell Completion" })
