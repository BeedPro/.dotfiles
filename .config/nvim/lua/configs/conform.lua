local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    typst = { "prettypst" },
    python = { "ruff_format" },
    haskell = { "fourmolu" },
    css = { "prettierd" },
    html = { "prettierd" },
    djangohtml = { "djlint" },
    htmldjango = { "djlint" },
    markdown = { "prettierd" },
    cs = { "csharpier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    java = { "clang-format" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    typescript = { "prettierd" },
    json = { "prettierd" },
    vue = { "prettierd" },
    svelte = { "prettierd" },
    ["cshtml"] = { "trim_whitespace" },
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
