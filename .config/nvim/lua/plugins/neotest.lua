return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local neotest = require "neotest"
      neotest.setup {
        adapters = {
          require "neotest-python" {
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
            python = ".venv/bin/python",
            pytest_discover_instances = false,
          },
          require "neotest-java",
          require "neotest-dotnet",
          require "neotest-plenary",
        },
      }
    end,
  },
  {
    "nvim-neotest/neotest-python",
    dependencies = "nvim-neotest/neotest",
  },

  {
    "nvim-neotest/neotest-plenary",
    dependencies = "nvim-neotest/neotest",
  },
  {
    "Issafalcon/neotest-dotnet",
    dependencies = "nvim-neotest/neotest",
  },

  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
  },
}
