local dap = require "dap"
local dap_view = require "dap-view"
local dap_virtual = require "nvim-dap-virtual-text"
local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "B", texthl = "DapBreakpoint" })
sign("DapBreakpointCondition", { text = "B", texthl = "DapBreakpointCondition" })
sign("DapLogPoint", { text = "L", texthl = "DapLogPoint" })
sign("DapStopped", { text = ">", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
sign("DapBreakpointRejected", { text = "X", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

dap_virtual.setup {}
dap_view.setup {}

dap.listeners.after.event_initialized["dap-view"] = function()
  dap_view.open()
end

dap.listeners.before.event_terminated["dap-view"] = function()
  dap_view.close(true)
end

dap.listeners.before.event_exited["dap-view"] = function()
  dap_view.close(true)
end
