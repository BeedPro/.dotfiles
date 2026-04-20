local lazypath = vim.fs.joinpath(vim.fn.stdpath "data", "lazy", "lazy.nvim")

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
local lazy_config = require "configs.lazy"

require("lazy").setup({
  require "plugins.blink",
  require "plugins.conform",
  require "plugins.dap-view",
  require "plugins.dap",
  require "plugins.diffview",
  require "plugins.friendly-snippets",
  require "plugins.gitsigns",
  require "plugins.haskell",
  require "plugins.kanso",
  require "plugins.lint",
  require "plugins.lsp",
  require "plugins.luasnip",
  require "plugins.mason",
  require "plugins.neogen",
  require "plugins.neogit",
  require "plugins.oil",
  require "plugins.plenary",
  require "plugins.telescope",
  require "plugins.treesitter",
  require "plugins.undotree",
  require "plugins.whichkey",
  require "plugins.icons",
}, lazy_config)
