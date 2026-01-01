local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

local map = vim.keymap.set

map({ "n", "x" }, "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

return options
