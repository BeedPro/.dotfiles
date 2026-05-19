-- This has been archived
-- if this breaks then install:
-- https://github.com/romus204/tree-sitter-manager.nvim
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
}
