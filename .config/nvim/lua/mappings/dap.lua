local map = vim.keymap.set
local dap = require "dap"
local dapui = require "dapui"

map("n", "<leader>d?", function()
  dapui.eval(nil, {
    enter = true,
    context = "hover",
    width = 200,
    height = 10,
  })
end, { desc = "[D]ap Question[?]" })
map("n", "<F5>", dap.continue, { desc = "Dap Continue" })
map("n", "<F10>", dap.step_over, { desc = "Dap Step Over" })
map("n", "<F11>", dap.step_into, { desc = "Dap Step Into" })
map("n", "<F12>", dap.step_out, { desc = "Dap Step Out" })
map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "[D]ap Toggle [B]reakpoint" })
map("n", "<Leader>dB", dap.set_breakpoint, { desc = "[D]ap Set [B]reakpoint" })
map("n", "<Leader>dr", dap.repl.open, { desc = "[D]ap [R]epl Open" })
map("n", "<Leader>dl", dap.run_last, { desc = "[D]ap Run [L]ast" })
