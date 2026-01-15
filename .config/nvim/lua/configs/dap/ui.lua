local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "B", texthl = "DapBreakpoint" })
sign("DapBreakpointCondition", { text = "B", texthl = "DapBreakpointCondition" })
sign("DapLogPoint", { text = "L", texthl = "DapLogPoint" })
sign("DapStopped", { text = ">", texthl = "DapStopped" })
sign("DapBreakpointRejected", { text = "X", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
