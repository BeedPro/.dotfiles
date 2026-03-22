---@diagnostic disable: different-requires
vim.pack.add {
  "https://github.com/sindrets/diffview.nvim",
}

local opts = require "configs.diffview"

require("diffview").setup(opts)
