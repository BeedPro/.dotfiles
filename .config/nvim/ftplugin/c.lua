vim.opt.makeprg = "make"

vim.opt.errorformat = table.concat({
  -- real diagnostics
  "%f:%l:%c: %trror: %m", -- error:
  "%f:%l:%c: %tarning: %m", -- warning:
  "%f:%l: %trror: %m",
  "%f:%l: %tarning: %m",

  -- optional: notes/info (keep or remove these two lines)
  -- "%f:%l:%c: note: %m",
  -- "%f:%l: note: %m",

  -- ignore generic noise
  "%-Gmake[%*\\d]: Entering directory '%f'",
  "%-Gmake[%*\\d]: Leaving directory '%f'",
  "%-G%\\s%#",
  "%-G%.%#",
}, ",")

-- Open quickfix only if there are valid entries
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "make",
  callback = function()
    vim.cmd "cwindow"
  end,
})
