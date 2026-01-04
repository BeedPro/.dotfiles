local dap = require "dap"

local home = os.getenv "HOME"
local mason_home = home .. "/.local/share/nvim/mason"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = mason_home .. "/bin/codelldb",
    args = { "--port", "${port}" },
  },
}
