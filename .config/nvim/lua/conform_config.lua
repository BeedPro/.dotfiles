vim.pack.add {
  "https://github.com/stevearc/conform.nvim",
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
    java = { "clang-format" },
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

vim.keymap.set({ "n", "x" }, "<leader>cf", function()
  require("conform").format { lsp_fallback = true, async = true }
end, { desc = "Format code" })
