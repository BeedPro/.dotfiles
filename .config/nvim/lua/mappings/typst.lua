local map = vim.keymap.set

map("n", "<leader>sn", function()
  require("commands.typst").new_main_note()
end, { desc = "Slip: new note" })

map("n", "<leader>si", function()
  require("commands.typst").insert_note()
end, { desc = "Slip: new note" })

map("n", "<leader>so", function()
  require("commands.typst").open_note()
end, { desc = "Slip: new note" })
