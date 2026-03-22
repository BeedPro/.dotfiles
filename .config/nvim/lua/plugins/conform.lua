vim.pack.add {
  "https://github.com/stevearc/conform.nvim",
}

local opts = require "configs.conform"

require("conform").setup(opts)
