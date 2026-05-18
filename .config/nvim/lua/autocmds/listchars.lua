local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opt = vim.opt

local listchars_insert = {
  tab = "> ",
  nbsp = "+",
}

local listchars_normal = vim.tbl_extend("force", listchars_insert, {
  trail = "-",
})

opt.listchars = listchars_normal

autocmd("InsertEnter", {
  group = augroup("ToggleListchars", { clear = true }),
  callback = function()
    vim.opt_local.listchars = listchars_insert
  end,
})

autocmd("InsertLeave", {
  group = augroup("ToggleListchars", { clear = false }),
  callback = function()
    vim.opt_local.listchars = listchars_normal
  end,
})
