local map = vim.keymap.set

map("n", "<leader>sn", function()
  require("commands.typst").new_main_note()
end, { desc = "Slip: new note" })
