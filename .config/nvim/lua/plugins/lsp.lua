vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

require("configs.lsp").setup()
