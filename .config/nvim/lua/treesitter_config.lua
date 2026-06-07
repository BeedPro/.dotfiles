vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
}

local parsers = {
  "c",
  "cpp",
  "css",
  "gdscript",
  "haskell",
  "htmldjango",
  "html",
  "javascript",
  "json",
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
  "prolog",
  "bash",
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterFileTypeStart", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_user_command("TSInstallAll", function()
  require("nvim-treesitter").install(parsers)
end, {
  desc = "Install predefined Treesitter parsers",
})
