vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
local lazy_config = require "configs.lazy"

require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

require "options"
require "autocmds"
require "commands"

vim.schedule(function()
  require "mappings"
end)

vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/snippets/luasnips"
vim.g.vscode_snippets_path = "./snippets/vscode"
