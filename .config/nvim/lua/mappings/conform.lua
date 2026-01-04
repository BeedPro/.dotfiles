local map = vim.keymap.set

map({ "n", "x" }, "<leader>fm", function()
  require("conform").format { lsp_fallback = true, async = true }
end, { desc = "general format file" })
