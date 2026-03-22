vim.pack.add {
  "https://github.com/danymat/neogen",
}

local opts = require "configs.neogen"

require("neogen").setup(opts)
