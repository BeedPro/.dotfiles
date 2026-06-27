local lsp = require "lsprc"
local treesitter = require "treesitter-rc"

vim.pack.add {
  "https://codeberg.org/mfussenegger/nvim-jdtls",
}

lsp.mason {
  "jdtls",
  "java-debug-adapter",
  "java-test",
}

treesitter.add { "java" }
