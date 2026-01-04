local map = vim.keymap.set
local neotest = require "neotest"

map("n", "<leader>tr", neotest.run.run, { desc = "[T]est [R]un" })

map("n", "<leader>tc", function()
  neotest.run.run(vim.fn.expand "%")
end, { desc = "[T]est [C]urrent file" })

map("n", "<leader>td", function()
  neotest.run.run { suite = false, strategy = "dap" }
end, { desc = "[T]est [D]ebug nearest" })

map("n", "<leader>ts", function()
  neotest.run.stop()
end, { desc = "[T]est [S]top" })

map("n", "<leader>ta", function()
  neotest.run.attach()
end, { desc = "[T]est [A]ttach" })
