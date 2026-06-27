local lsp = require "lsp-rc"
local mason = require "mason-rc"
local quality = require "quality-rc"
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
