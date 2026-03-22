vim.pack.add {
  "https://github.com/igorlfs/nvim-dap-view",
}

vim.cmd.packadd "nvim-dap-view"

local opts = require "configs.dap.view"

require("dap-view").setup(opts)
