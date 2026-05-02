local autocmd = vim.api.nvim_create_autocmd
local events = { "BufWritePost", "BufReadPost", "InsertLeave", "BufEnter" }
local lint = require "lint"

autocmd(events, {
  callback = function()
    lint.try_lint()
  end,
})
