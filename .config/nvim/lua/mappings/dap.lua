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

map("n", "<leader>dc", dap.continue, { desc = "[D]ap [C]ontinue" })
map("n", "<leader>dn", dap.step_over, { desc = "[D]ap [N]ext (Step Over)" })
map("n", "<leader>di", dap.step_into, { desc = "[D]ap [I]nto (Step Into)" })
map("n", "<leader>do", dap.step_out, { desc = "[D]ap [O]ut (Step Out)" })

map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "[D]ap Toggle [B]reakpoint" })
map("n", "<Leader>dB", dap.set_breakpoint, { desc = "[D]ap Set [B]reakpoint" })
map("n", "<Leader>dr", dap.repl.open, { desc = "[D]ap [R]epl Open" })
map("n", "<Leader>dl", dap.run_last, { desc = "[D]ap Run [L]ast" })
map("n", "<Leader>dt", dap.terminate, { desc = "[D]ap [T]erminate" })
