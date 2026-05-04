local map = vim.keymap.set

map("n", "<leader>mks", function()
  vim.ui.input({ prompt = "Session name: " }, function(input)
    if input == nil or input == "" then
      return
    end

    MiniSessions.write(input)
  end)
end, { desc = "[M]ini add [S]ession" })

map("n", "<leader>mso", function()
  MiniSessions.select "read"
end, { desc = "[M]ini add [S]ession" })
