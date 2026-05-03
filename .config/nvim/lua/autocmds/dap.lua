local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local ui = require "configs.dap.ui"

autocmd("ColorScheme", {
  group = augroup("DapColorScheme", { clear = true }),
  callback = function()
    vim.schedule(ui.setup)
  end,
})
