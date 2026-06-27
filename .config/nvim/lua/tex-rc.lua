local lsp = require "lsp-rc"
local quality = require "quality-rc"

lsp.enable { "texlab" }

quality.formatters {
  tex = { "tex-fmt" },
}
