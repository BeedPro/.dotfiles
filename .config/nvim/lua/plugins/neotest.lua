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
      require "configs.neotest"
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
      "theHamsta/nvim-dap-virtual-text",
    },
  },
}
