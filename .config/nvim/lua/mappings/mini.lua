local map = vim.keymap.set

map("n", "<leader>mso", function()
  MiniSessions.read()
end, { desc = "[M]ini [S][O]urce Session" })

map("n", "<leader>mds", function()
  MiniSessions.delete()
end, { desc = "[M]ini [D]elete [S]ession" })
