local dap = require "dap"

local home = os.getenv "HOME"
local mason_home = home .. "/.local/share/nvim/mason"
local js_debug_adapter = mason_home .. "/bin/js-debug-adapter"

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
