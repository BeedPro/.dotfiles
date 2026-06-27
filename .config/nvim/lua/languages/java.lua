local lsp = require "lsprc"
local mason = require "masonrc"
local treesitter = require "treesitter-rc"

vim.pack.add {
  "https://codeberg.org/mfussenegger/nvim-jdtls",
}

mason.add {
  "jdtls",
  "java-debug-adapter",
  "java-test",
}

treesitter.add { "java" }
