vim.g.mapleader = " "

require "plugins"
require "options"
require "autocmds"
require "commands"

vim.schedule(function()
  require "mappings"
end)

vim.cmd.colorscheme "modus"
