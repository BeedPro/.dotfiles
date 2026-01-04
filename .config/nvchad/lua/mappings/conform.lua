local map = vim.keymap.set

map({ "n", "x" }, "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format current buffer" })
