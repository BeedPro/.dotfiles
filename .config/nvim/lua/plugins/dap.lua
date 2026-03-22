vim.schedule(function()
  vim.pack.add {
    "https://github.com/mfussenegger/nvim-dap",
  }

  require "configs.dap"
end)
