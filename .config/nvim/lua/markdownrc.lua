local quality = require "quality"
local treesitter = require "treesitter-rc"

treesitter.add {
  "markdown",
  "markdown_inline",
}

quality.formatters {
  markdown = { "prettierd" },
}
