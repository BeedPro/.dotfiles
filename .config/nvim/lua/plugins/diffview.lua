vim.pack.add {
  "https://github.com/sindrets/diffview.nvim",
}

vim.cmd.packadd "diffview.nvim"

local opts = require "configs.diffview"

require("diffview").setup(opts)
