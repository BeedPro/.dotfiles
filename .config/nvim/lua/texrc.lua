local lsp = require "lsprc"
local quality = require "quality"

lsp.enable { "texlab" }

quality.formatters {
  tex = { "tex-fmt" },
}
