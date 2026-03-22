---@diagnostic disable: different-requires
vim.pack.add {
  "https://github.com/j-hui/fidget.nvim",
}

vim.cmd.packadd "fidget.nvim"

local opts = require "configs.fidget"

require("fidget").setup(opts)
