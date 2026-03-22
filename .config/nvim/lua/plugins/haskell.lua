vim.pack.add({
  {
    src = "https://github.com/mrcjkb/haskell-tools.nvim",
    version = vim.version.range("7"),
  },
})

vim.cmd.packadd "haskell-tools.nvim"
