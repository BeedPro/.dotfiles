local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local ls = require "luasnip"

-- Fixes https://github.com/L3MON4D3/LuaSnip/issues/258
autocmd("InsertLeave", {
  group = augroup("LuasnipCleanup", { clear = true }),
  callback = function()
    if ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then
      ls.unlink_current()
    end
  end,
})
