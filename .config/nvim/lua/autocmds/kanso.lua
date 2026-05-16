local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local setup = function()
  local hl = vim.api.nvim_set_hl

  local colors = require("kanso.colors").setup()

  hl(0, "debugPC", {
    bg = colors.theme.ui.bg_dim,
  })
end

autocmd("ColorScheme", {
  group = augroup("DapColorScheme", { clear = true }),
  callback = function()
    vim.schedule(setup)
  end,
})
