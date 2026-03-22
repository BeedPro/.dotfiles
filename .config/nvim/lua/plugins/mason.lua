vim.pack.add {
  "https://github.com/mason-org/mason.nvim",
}

vim.cmd.packadd "mason.nvim"

local opts = require "configs.mason"

require("mason").setup(opts)
