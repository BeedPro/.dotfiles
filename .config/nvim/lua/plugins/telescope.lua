vim.pack.add {
  "https://github.com/nvim-telescope/telescope.nvim",
}

vim.cmd.packadd "telescope.nvim"

local opts = require "configs.telescope"

require("telescope").setup(opts)
