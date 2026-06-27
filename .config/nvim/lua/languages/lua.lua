local lsp = require "lsprc"
local quality = require "quality"
local treesitter = require "treesitter-rc"

lsp.enable { "lua_ls" }
lsp.mason {
  "lua-language-server",
  "stylua",
}

treesitter.add { "lua" }

quality.formatters {
  lua = { "stylua" },
}
