local dap_python = require "dap-python"
local home = os.getenv "HOME"
local path = home .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
-- dap_python.test_runner = "pytest"
dap_python.setup(path)
local map = vim.keymap.set

-- map("n", "<leader>tr", dap_python.test_method, { desc = "Python-DAP Test Method" })
-- map("n", "<leader>tc", dap_python.test_class, { desc = "Python-DAP Test Class" })
