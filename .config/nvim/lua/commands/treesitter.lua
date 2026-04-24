local command = vim.api.nvim_create_user_command
local pkgs = require "configs.treesitter.required"
local ts = require "nvim-treesitter"

command("TSInstallAll", function()
  ts.install(pkgs)
end, {
  desc = "Install predefined Treesitter parsers",
})
