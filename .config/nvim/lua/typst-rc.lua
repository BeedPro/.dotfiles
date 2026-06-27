local lsp = require "lsp-rc"
local quality = require "quality-rc"
local treesitter = require "treesitter-rc"

lsp.enable { "tinymist" }

treesitter.add { "typst" }

quality.formatters {
  typst = { "prettypst" },
}
