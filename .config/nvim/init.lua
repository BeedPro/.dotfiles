vim.g.mapleader = " "
vim.g.lua_snippets_path = vim.fs.joinpath(vim.fn.stdpath "config", "snippets", "luasnips")
vim.g.snipmate_snippets_path = vim.fs.joinpath(vim.fn.stdpath "config", "snippets", "snipmate")
vim.g.vscode_snippets_path = vim.fs.joinpath(vim.fn.stdpath "config", "snippets", "vscode")

require "plugins"
require "options"
require "autocmds"
require "commands"

vim.schedule(function()
  require "mappings"
end)

vim.cmd "colorscheme kanso"
