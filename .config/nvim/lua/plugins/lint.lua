vim.pack.add {
  "https://github.com/mfussenegger/nvim-lint",
}

vim.cmd.packadd "nvim-lint"

require "configs.linter"
