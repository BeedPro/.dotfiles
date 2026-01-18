local o = vim.o
o.spell = true
o.spelllang = "en_gb"

local map = vim.keymap.set
local builtin = require "telescope.builtin"

map("n", "<space>frb", function()
  local name = vim.fn.expand "%:t:r"
  if name == "" then
    return
  end
  builtin.live_grep { default_text = "(" .. name .. ")" }
end, { desc = "Search '(filename)' (no ext)" })
