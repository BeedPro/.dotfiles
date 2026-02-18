local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    typst = { "prettypst" },
    python = { "ruff_format", "isort" },
    djangohtml = { "djlint" },
    htmldjango = { "djlint" },
    haskell = { "fourmolu" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    java = { "clang-format" },
    css = { "biome" },
    html = { "biome" },
    markdown = { "biome" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescriptreact = { "biome" },
    typescript = { "biome" },
    json = { "biome" },
    vue = { "biome" },
    svelte = { "biome" },
    ["_"] = { "trim_whitespace" },
  },

  format_on_save = function(bufnr)
    local excluded_filetypes = {
      scala = true,
    }

    if excluded_filetypes[vim.bo[bufnr].filetype] then
      return nil
    end

    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
}

return options
