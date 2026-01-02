local ls = require "luasnip"
local map = vim.keymap.set

map({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })

map({ "i", "s" }, "<C-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
