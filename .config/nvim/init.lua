vim.g.mapleader = " "
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/snippets/luasnips"
vim.g.vscode_snippets_path = "./snippets/vscode"

require "plugins"
require "options"
require "autocmds"
require "commands"

vim.schedule(function()
  require "mappings"
end)
