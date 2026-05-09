local map = vim.keymap.set

map("n", "<leader>so", function()
  MiniSessions.read()
end, { desc = "[M]ini [S][O]urce Session" })

map("n", "<leader>sd", function()
  MiniSessions.delete()
end, { desc = "[M]ini [D]elete [S]ession" })
