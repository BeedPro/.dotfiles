local options = {
  formatters_by_ft = {
    python = { "ruff_format", "ruff_organize_imports" },
    djangohtml = { "djlint" },
    htmldjango = { "djlint" },
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

  format_on_save = function(bufnr)
    local excluded_filetypes = {
      cpp = true,
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
