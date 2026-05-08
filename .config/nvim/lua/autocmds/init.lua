local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

require "autocmds.bigfile"
require "autocmds.typst"
require "autocmds.django"
require "autocmds.oil"
require "autocmds.kanso"
require "autocmds.opener"
require "autocmds.lsp"
require "autocmds.luasnip"
require "autocmds.nvim-lint"
require "autocmds.mini"

autocmd("TextYankPost", {
  group = augroup("HighlightYank", { clear = true }),
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
  group = augroup("TreesitterFileTypeStart", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

autocmd("VimResized", {
  group = augroup("AutoResizeSplits", { clear = true }),
  command = "wincmd =",
})
