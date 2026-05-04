local map = vim.keymap.set

map("n", "<Right>", function()
  require("dap").step_into()
end, { desc = "[D]ap Step [I]nto" })

map("n", "<Down>", function()
  require("dap").step_over()
end, { desc = "[D]ap Step [O]ver" })

map("n", "<Left>", function()
  require("dap").step_out()
end, { desc = "[D]ap Step O[u]t" })

map("n", "<Up>", function()
  require("dap").restart_frame()
end, { desc = "[D]ap [R]estart Frame" })

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "[D]ap Toggle [B]reakpoint" })

map("n", "<leader>dw", function()
  require("dap-view").add_expr()
end, { desc = "[D]ap Add [W]atch" })

map("n", "<leader>dr", function()
  require("dap").continue()
end, { desc = "[D]ap [R]un/Continue" })

map("n", "<leader>dR", function()
  require("dap").restart()
end, { desc = "[D]ap [R]estart" })

map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "[D]ap Run [L]ast" })

map("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "[D]ap [T]erminate" })

map("n", "<leader>dk", function()
  require("dap-view").hover()
end, { desc = "[D]ap Hover Pee[k]" })

map("n", "<leader>dv", function()
  require("dap-view").virtual_text_toggle()
end, { desc = "[D]ap [V]irtual Text Toggle" })
