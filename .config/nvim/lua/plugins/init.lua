local lazypath = vim.fs.joinpath(vim.fn.stdpath "data", "lazy", "lazy.nvim")

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
local lazy_config = require "configs.lazy"

require("lazy").setup({
  require "plugins.mason",
  require "plugins.lsp",
  require "plugins.treesitter",
  require "plugins.conform",
  require "plugins.lint",
  require "plugins.blink-cmp",
  require "plugins.blink-cmp-spell",
  require "plugins.dap",
  require "plugins.dap-view",
  require "plugins.neogit",
  require "plugins.gitsigns",
  require "plugins.diffview",
  require "plugins.luasnip",
  require "plugins.friendly-snippets",
  require "plugins.neogen",
  require "plugins.kanso",
  require "plugins.oil",
  require "plugins.fzf-lua",
  require "plugins.whichkey",
  require "plugins.lazydev",
}, lazy_config)

require "plugins.undotree"
require "plugins.difftool"
require("vim._core.ui2").enable {}
