opts = {
  ensure_installed = {
    "vim",
    "lua",
    "vimdoc",
    "html",
    "css",
    "groovy",
    "python",
    "markdown",
    "markdown_inline",
    "typescript",
    "c_sharp",
    "commonlisp",
    "typst",
    "c",
    "cpp",
    "svelte",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true, disable = { "cpp" } },
}

require("nvim-treesitter.configs").setup(opts)
