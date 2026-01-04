local dap_python = require "dap-python"

local home = os.getenv "HOME"
local python = home .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

dap_python.setup(python)
