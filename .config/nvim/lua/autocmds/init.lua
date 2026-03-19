local autocmd = vim.api.nvim_create_autocmd

require "autocmds.ready"
require "autocmds.numbertoggle"
require "autocmds.conform"
require "autocmds.bigfile"
require "autocmds.typst"
require "autocmds.django"
require "autocmds.oil"
require "autocmds.lsp_progress"

require("autocmds.colorify").run()

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})
