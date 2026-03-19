return {
  "neovim/nvim-lspconfig",
  event = "User FilePost",
  dependencies = {
    {
      "mason-org/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      opts = require "configs.mason",
    },

    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    require("configs.lsp").setup()
  end,
}
