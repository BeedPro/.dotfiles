local dap = require "dap"

local home = os.getenv "HOME"
local mason_home = home .. "/.local/share/nvim/mason"

dap.adapters.coreclr = {
  type = "executable",
  command = mason_home .. "/bin/netcoredbg",
  args = { "--interpreter=vscode" },
}
