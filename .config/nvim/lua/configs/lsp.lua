local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  preselectSupport = true,
  commitCharactersSupport = true,
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

vim.diagnostic.config {
  underline = false,
}

vim.lsp.config("*", {
  capabilities = capabilities,
})

local servers = {
  "ty",
  "clangd",
  "hls",
  "tinymist",
  "prolog_ls",
  "lua_ls",
  "biome",
  "ts_ls",
  "tailwindcss",
  "svelte",
  "gdscript",
}

vim.lsp.enable(servers)
