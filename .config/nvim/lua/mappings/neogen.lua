local map = vim.keymap.set

map("n", "<leader>ca", function()
  require("neogen").generate()
end, { desc = "[C]ode [A]nnotation" })
