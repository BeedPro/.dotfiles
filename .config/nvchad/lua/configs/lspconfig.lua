require("nvchad.configs.lspconfig").defaults()

local lspconfig = vim.lsp.config
local enable = vim.lsp.enable

vim.diagnostic.config { virtual_text = false }

local servers = { "html", "cssls", "roslyn", "pyright", "clangd", "tinymist", "svelte" }
enable(servers)

lspconfig("svelte", {})
lspconfig("tinymist", {})
lspconfig("clangd", {})

lspconfig("roslyn", {
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})

lspconfig("pyright", {
  settings = {
    pyright = { autoImportCompletion = true },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "on",
      },
    },
  },
})
