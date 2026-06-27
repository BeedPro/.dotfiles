local lsp = require "lsprc"
local quality = require "quality"
local treesitter = require "treesitter-rc"

lsp.enable { "tinymist" }

treesitter.add { "typst" }

quality.formatters {
  typst = { "prettypst" },
}
