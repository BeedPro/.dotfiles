vim.schedule(function()
  vim.pack.add {
    "https://github.com/lewis6991/gitsigns.nvim",
  }

  local opts = require "configs.gitsigns"

  require("gitsigns").setup(opts)
end)
