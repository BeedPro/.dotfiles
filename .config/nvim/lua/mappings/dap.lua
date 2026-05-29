local map = vim.keymap.set

map("n", "<Right>", function()
  require("dap").step_into()
end, { desc = "Debug: step into" })

map("n", "<Down>", function()
  require("dap").step_over()
end, { desc = "Debug: step over" })

map("n", "<Left>", function()
  require("dap").step_out()
end, { desc = "Debug: step out" })

map("n", "<Up>", function()
  require("dap").restart_frame()
end, { desc = "Debug: restart frame" })

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug: toggle breakpoint" })

map("n", "<leader>dw", function()
  require("dap-view").add_expr()
end, { desc = "Debug: add watch expression" })

map("n", "<leader>dr", function()
  require("dap").continue()
end, { desc = "Debug: run or continue" })

map("n", "<leader>dR", function()
  require("dap").restart()
end, { desc = "Debug: restart session" })

map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Debug: run last configuration" })

map("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "Debug: terminate session" })

map("n", "<leader>dk", function()
  require("dap-view").hover()
end, { desc = "Debug: hover value" })

map("n", "<leader>dv", function()
  require("dap-view").virtual_text_toggle()
end, { desc = "Debug: toggle virtual text" })
