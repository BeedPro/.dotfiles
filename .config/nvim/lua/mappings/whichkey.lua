local map = vim.keymap.set

map("n", "<leader>?", function()
  require("which-key").show { global = false }
end, { desc = "Which key[?]" })
