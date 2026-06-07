vim.pack.add {
  "https://github.com/igorlfs/nvim-dap-view",
}

require("dap-view").setup {
  winbar = {
    sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
    default_section = "scopes",
    controls = { enabled = true },
  },
  windows = {
    terminal = {
      size = 0.40,
      position = "right",
      hide = { "delve" },
    },
  },
  auto_toggle = true,
}

vim.keymap.set("n", "<leader>dw", function()
  require("dap-view").add_expr()
end, { desc = "Debug: add watch expression" })
vim.keymap.set("n", "<leader>dk", function()
  require("dap-view").hover()
end, { desc = "Debug: hover value" })
vim.keymap.set("n", "<leader>dv", function()
  require("dap-view").virtual_text_toggle()
end, { desc = "Debug: toggle virtual text" })
