local opts = {
  ensure_installed = {
    "c",
    "cpp",
    "css",
    "gdscript",
    "haskell",
    "htmldjango",
    "html",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "python",
    "markdown",
    "markdown_inline",
    "query",
    "svelte",
    "tsx",
    "typescript",
    "typst",
    "vim",
    "vimdoc",
    "yaml",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true, disable = { "cpp" } },
}

require("nvim-treesitter.configs").setup(opts)
