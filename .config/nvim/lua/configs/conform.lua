local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    typst = { "prettypst" },
    python = { "ruff_format", "ruff_organize_imports" },
    djangohtml = { "djlint" },
    htmldjango = { "djlint" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    css = { "biome" },
    html = { "biome" },
    markdown = { "prettierd" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescriptreact = { "biome" },
    typescript = { "biome" },
    json = { "biome" },
    svelte = { "biome" },
    gdscript = { "gdformat" },
    tex = { "tex-fmt" },
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
