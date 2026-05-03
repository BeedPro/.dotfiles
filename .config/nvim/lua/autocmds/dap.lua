local autocmd = vim.api.nvim_create_autocmd
local ui = require "configs.dap.ui"

autocmd("ColorScheme", {
  callback = function()
    vim.schedule(ui.setup)
  end,
})
