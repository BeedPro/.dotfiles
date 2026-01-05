local map = vim.keymap.set

local harpoon = require "harpoon"
harpoon:setup()

map("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "[A]dd File Harpoon" })

map("n", "<leader>he", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[H]arpoon [E]xplore List" })

for i = 1, 5 do
  map("n", "<A-" .. i .. ">", function()
    harpoon:list():select(i)
  end, { desc = "Harpoon select [" .. i .. "]" })
end

map("n", "[h", function()
  harpoon:list():prev()
end, { desc = "[Previous [H]arppon file" })

map("n", "]h", function()
  harpoon:list():next()
end, { desc = "]Next [H]arppon file" })
