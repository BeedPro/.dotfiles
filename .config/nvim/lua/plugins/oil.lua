vim.pack.add {
  "https://github.com/stevearc/oil.nvim",
}

vim.cmd.packadd "oil.nvim"

local opts = require "configs.oil"

require("oil").setup(opts)
