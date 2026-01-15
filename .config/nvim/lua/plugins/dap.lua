return {
  {
    "igorlfs/nvim-dap-view",
    lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
    },
    opts = {
      winbar = {
        sections = { "console", "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
        default_section = "console",
        controls = { enabled = true },
      },
      auto_toggle = true,
    },
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
    },
    config = function()
      require "configs.dap.adapters.python"
    end,
  },
}
