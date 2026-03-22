vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1"),
  },
})

vim.cmd.packadd "blink.cmp"

local opts = require "configs.blink"

require("blink.cmp").setup(opts)
