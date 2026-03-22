vim.pack.add {
  "https://github.com/mason-org/mason.nvim",
}

local opts = require "configs.mason"

require("mason").setup(opts)
