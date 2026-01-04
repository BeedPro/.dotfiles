return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require "configs.dap.ui"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap_python = require "dap-python"
      local home = os.getenv "HOME"
      local path = home .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      dap_python.setup(path)
    end,
  },
}
