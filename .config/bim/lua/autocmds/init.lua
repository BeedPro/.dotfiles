local autocmd = vim.api.nvim_create_autocmd

require "autocmds.ready"
require "autocmds.numbertoggle"
require "autocmds.conform"
require "autocmds.signature"

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})
