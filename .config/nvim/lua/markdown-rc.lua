local quality = require "quality-rc"
local treesitter = require "treesitter-rc"

treesitter.add {
  "markdown",
  "markdown_inline",
}

quality.formatters {
  markdown = { "prettierd" },
}
