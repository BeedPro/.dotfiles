local map = vim.keymap.set

map("n", "<leader>so", function()
  MiniSessions.read()
end, { desc = "[M]ini [S][O]urce Session" })
