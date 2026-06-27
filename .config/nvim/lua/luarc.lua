local lsp = require "lsprc"
local mason = require "masonrc"
local quality = require "quality"
local treesitter = require "treesitter-rc"

lsp.enable { "lua_ls" }
mason.add {
  "lua-language-server",
  "stylua",
}

treesitter.add { "lua" }

quality.formatters {
  lua = { "stylua" },
}
