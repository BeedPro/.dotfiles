local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opt = vim.opt

autocmd("InsertEnter", {
  group = augroup("ToggleListchars", { clear = true }),
  callback = function()
    opt.list = false
  end,
})

autocmd("InsertLeave", {
  group = augroup("ToggleListchars", { clear = false }),
  callback = function()
    opt.list = true
  end,
})
