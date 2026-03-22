vim.pack.add {
  "https://github.com/stevearc/conform.nvim",
}

vim.cmd.packadd "conform.nvim"

local opts = require "configs.conform"

require("conform").setup(opts)
