vim.pack.add {
  "https://github.com/danymat/neogen",
}

vim.cmd.packadd "neogen"

local opts = require "configs.neogen"

require("neogen").setup(opts)
