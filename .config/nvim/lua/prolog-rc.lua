local lsp = require "lsp-rc"
local quality = require "quality-rc"
local treesitter = require "treesitter-rc"

lsp.enable { "prolog_ls" }

treesitter.add { "prolog" }

quality.formatters {
  prolog = { "prolog" },
}
