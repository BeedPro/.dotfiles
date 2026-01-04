local map = vim.keymap.set

local harpoon = require "harpoon"
harpoon:setup()

map("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "[A]dd File Harpoon" })

map("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[E]xplore Harpoon List" })

for i = 1, 5 do
  map("n", "<A-" .. i .. ">", function()
    harpoon:list():select(i)
  end, { desc = "Harpoon select [" .. i .. "]" })
end
