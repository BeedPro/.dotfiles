vim.pack.add {
  "https://github.com/stevearc/oil.nvim",
}

local opts = require "configs.oil"

require("oil").setup(opts)
