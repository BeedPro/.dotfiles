local map = vim.keymap.set

map("n", "<Right>", function()
  require("dap").step_into()
end, { desc = "[D]ap [I]nto (Step Into)" })

map("n", "<Down>", function()
  require("dap").step_over()
end, { desc = "[D]ap [N]ext (Step Over)" })

map("n", "<Left>", function()
  require("dap").step_out()
end, { desc = "[D]ap [O]ut (Step Out)" })

map("n", "<Up>", function()
  require("dap").restart_frame()
end, { desc = "[D]ap [R]estart Frame" })

map("n", "<leader>b", function()
  require("dap").toggle_breakpoint()
end, { desc = "[D]ap Toggle [B]reakpoint" })

map("n", "<leader>dd", function()
  require("dap").continue()
end, { desc = "[D]ap [C]ontinue" })

map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "[D]ap Run [L]ast" })

map("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "[D]ap [T]erminate" })
