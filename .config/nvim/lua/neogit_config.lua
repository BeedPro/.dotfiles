vim.pack.add {
  "https://github.com/NeogitOrg/neogit",
}

require("neogit").setup {
  disable_hint = true,
}

vim.keymap.set("n", "<leader>gg", function()
  require("neogit").open()
end, { desc = "Open Neogit" })
