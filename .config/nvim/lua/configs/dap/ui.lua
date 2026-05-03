local M = {}

M.setup = function()
  local sign = vim.fn.sign_define
  local hl = vim.api.nvim_set_hl

  hl(0, "debugPC", {
    link = "Visual",
  })

  sign("DapStopped", { text = "> ", texthl = "SignColumn", linehl = "debugPC" })
end

return M
