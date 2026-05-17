require "mappings.oil"
require "mappings.fzf-lua"
require "mappings.neogen"
require "mappings.dap"
require "mappings.conform"
require "mappings.neogit"
require "mappings.blink-cmp"

local map = vim.keymap.set

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "[D]iagnostic [S]how (loclist)" })
map("n", "<leader>da", vim.diagnostic.setqflist, { desc = "[D]iagnostic [A]ll (quickfix)" })
map("n", "<leader>ta", function()
  if vim.wo.arabic then
    vim.cmd "set noarab"
    return
  end

  vim.cmd "set arab"
end, { desc = "[T]oggle [A]rabic" })

map("i", "<C-^>", function()
  if vim.wo.arabic then
    return vim.api.nvim_replace_termcodes("<C-o>:set noarab<CR>", true, false, true)
  end

  return vim.api.nvim_replace_termcodes("<C-o>:set arab<CR>", true, false, true)
end, { expr = true, desc = "Toggle arabic" })
