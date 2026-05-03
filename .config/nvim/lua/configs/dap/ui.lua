local M = {}

M.setup = function()
  local sign = vim.fn.sign_define
  local hl = vim.api.nvim_set_hl

  local colors = require("kanso.colors").setup()

  hl(0, "debugPC", {
    bg = colors.theme.ui.bg_dim,
  })

  sign("DapStopped", { text = "> ", texthl = "SignColumn", linehl = "debugPC" })
end

return M
