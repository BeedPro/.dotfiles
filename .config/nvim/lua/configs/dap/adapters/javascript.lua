local dap = require "dap"

local home = os.getenv "HOME"
local mason_home = home .. "/.local/share/nvim/mason"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      mason_home .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  },
}
