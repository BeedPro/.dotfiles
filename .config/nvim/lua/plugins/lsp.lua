return {
  "neovim/nvim-lspconfig",
  event = "User FilePost",
  config = function()
    require("configs.lsp").setup()
  end,
}
