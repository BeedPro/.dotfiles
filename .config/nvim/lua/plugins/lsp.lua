vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

vim.cmd.packadd "nvim-lspconfig"

require("configs.lsp").setup()
