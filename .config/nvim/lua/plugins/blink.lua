local autocmd = vim.api.nvim_create_autocmd

autocmd({ "InsertEnter", "CmdLineEnter" }, {
  once = true,
  callback = function()
    vim.pack.add {
      {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range "1",
      },
    }
    local opts = require "configs.blink"

    require("blink.cmp").setup(opts)
  end,
})
