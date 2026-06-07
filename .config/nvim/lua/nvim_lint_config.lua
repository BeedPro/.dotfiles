vim.pack.add {
  "https://github.com/mfussenegger/nvim-lint",
}

require("lint").linters_by_ft = {
  python = { "ruff" },
  htmldjango = { "djlint" },
  c = { "cpplint" },
  cpp = { "cpplint" },
  haskell = { "hlint" },
  typescript = { "biomejs" },
  typescriptreact = { "biomejs" },
  javascript = { "biomejs" },
  javascriptreact = { "biomejs" },
  json = { "biomejs" },
  html = { "biomejs" },
  css = { "biomejs" },
  svelte = { "biomejs" },
  gdscript = { "gdlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})
