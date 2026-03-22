vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "master",
  },
})

vim.cmd.packadd "nvim-treesitter"

require "configs.treesitter"
