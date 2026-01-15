local map = vim.keymap.set

map({ "n", "x" }, "<leader>cf", function()
  require("conform").format { lsp_fallback = true, async = true }
end, { desc = "[C]onform [F]ormat" })
