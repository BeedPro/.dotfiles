vim.schedule(function()
  vim.pack.add {
    "https://github.com/mfussenegger/nvim-lint",
  }

  require "configs.linter"
end)
