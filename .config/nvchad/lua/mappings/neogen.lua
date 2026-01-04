local map = vim.keymap.set
local neogen = require "neogen"

map("n", "<leader>cn", function()
  neogen.generate()
end, { desc = "Generate comments using Neogen" })
