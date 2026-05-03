local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

require "autocmds.bigfile"
require "autocmds.typst"
require "autocmds.django"
require "autocmds.oil"
require "autocmds.dap"
require "autocmds.opener"
require "autocmds.lsp"
require "autocmds.luasnip"
require "autocmds.nvim-lint"

autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

autocmd("BufRead", {
  group = augroup("DotenvFt", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})

autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
