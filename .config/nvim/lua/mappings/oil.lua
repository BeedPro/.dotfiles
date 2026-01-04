local map = vim.keymap.set
local o = vim.o

map("n", "<leader>.", function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open()
  end
end, { desc = "[.] Toggle Oil" })
