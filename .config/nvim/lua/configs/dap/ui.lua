local dap = require "dap"
local dapui = require "dapui"
local dap_virtual = require "nvim-dap-virtual-text"
local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "B", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "B", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "L", texthl = "DapLogPoint", linehl = "", numhl = "" })
sign("DapStopped", { text = "S", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
sign("DapBreakpointRejected", { text = "X", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

dap_virtual.setup {}
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
