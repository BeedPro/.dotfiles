vim.pack.add {
  "https://github.com/folke/which-key.nvim",
}

vim.cmd.packadd "which-key.nvim"

local opts = require "configs.whichkey"

require("which-key").setup(opts)
