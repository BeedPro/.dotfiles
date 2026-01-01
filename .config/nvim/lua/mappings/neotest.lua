local map = vim.keymap.set
local neotest = require "neotest"

map("n", "<leader>tr", neotest.run.run, { desc = "Neotest Run nearest test" })
map("n", "<leader>tc", function()
  neotest.run.run(vim.fn.expand "%")
end, { desc = "Neotest Run current file tests" })
map("n", "<leader>td", function()
  neotest.run.run { strategy = "dap" }
end, { desc = "Neotest Debug the nearest test" })
map("n", "<leader>ts", function()
  neotest.run.stop()
end, { desc = "Neotest Stop nearest test" })

map("n", "<leader>ta", function()
  neotest.run.attach()
end, { desc = "Neotest Attach to the nearest test" })
