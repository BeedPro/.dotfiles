local dap = require "dap"

local mason_home = vim.fs.joinpath(vim.fn.stdpath "data", "mason")
local js_debug_adapter = vim.fs.joinpath(mason_home, "bin", "js-debug-adapter")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = js_debug_adapter,
    args = {
      "${port}",
    },
  },
}
