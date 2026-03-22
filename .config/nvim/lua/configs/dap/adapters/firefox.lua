local dap = require "dap"

local home = os.getenv "HOME"
local mason_home = home .. "/.local/share/nvim/mason"

dap.adapters.firefox = {
  type = "executable",
  command = "node",
  args = {
    mason_home .. "/packages/firefox-debug-adapter/dist/adapter.bundle.js",
  },
}
