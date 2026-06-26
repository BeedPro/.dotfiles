vim.pack.add {
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
}

require("conform").setup {
  formatters_by_ft = {
    python = { "ruff_format", "ruff_organize_imports" },
    djangohtml = { "djlint" },
    htmldjango = { "djlint" },
    tex = { "tex-fmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    haskell = { "fourmolu" },
    typst = { "prettypst" },
    prolog = { "prolog" },
    lua = { "stylua" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    json = { "biome" },
    html = { "biome" },
    css = { "biome" },
    svelte = { "biome" },
    gdscript = { "gdformat" },
    markdown = { "prettierd" },
    ["_"] = { "trim_whitespace" },
  },
  format_on_save = {
    lsp_format = "never",
    formatters = { "trim_whitespace" },
  },
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

vim.keymap.set({ "n", "x" }, "<leader>cf", function()
  require("conform").format { lsp_format = "first", async = true }
end, { desc = "Format code" })

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})
