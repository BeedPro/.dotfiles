local lsp = require "lsprc"
local quality = require "quality"
local treesitter = require "treesitter-rc"

lsp.enable { "prolog_ls" }

treesitter.add { "prolog" }

quality.formatters {
  prolog = { "prolog" },
}
