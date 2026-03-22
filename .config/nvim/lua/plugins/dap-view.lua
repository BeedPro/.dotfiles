vim.schedule(function()
  vim.pack.add {
    "https://github.com/igorlfs/nvim-dap-view",
  }

  local opts = require "configs.dap.view"

  require("dap-view").setup(opts)
end)
