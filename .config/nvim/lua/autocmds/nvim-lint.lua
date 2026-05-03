local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local events = { "BufWritePost", "BufReadPost", "InsertLeave", "BufEnter" }
local lint = require "lint"

autocmd(events, {
  group = augroup("NvimLint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})
