local map = vim.keymap.set

map("n", "<leader>tr", function()
  require("neotest").run.run()
end, { desc = "[T]est [R]un" })

map("n", "<leader>tc", function()
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "[T]est [C]urrent file" })

map("n", "<leader>td", function()
  require("neotest").run.run { suite = false, strategy = "dap" }
end, { desc = "[T]est [D]ebug nearest" })

map("n", "<leader>ts", function()
  require("neotest").run.stop()
end, { desc = "[T]est [S]top" })

map("n", "<leader>ta", function()
  require("neotest").run.attach()
end, { desc = "[T]est [A]ttach" })
