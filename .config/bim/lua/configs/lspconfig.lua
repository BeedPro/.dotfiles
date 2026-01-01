local M = {}

M.on_attach = function(_, bufnr)
  local map = vim.keymap.set
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "K", function()
    vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
  end, opts "Hover documentation")
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "<leader>ra", vim.lsp.buf.rename, opts "[R]e[n]ame")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  -- map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
end

M.on_init = function(client)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.setup = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      M.on_attach(_, args.buf)
    end,
  })

  vim.lsp.config("*", {
    on_attach = M.on_attach,
    on_init = M.on_init,
    capabilities = M.capabilities,
  })

  -- Lua language server
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    },
  })

  local servers = { "lua_ls" }

  vim.lsp.enable(servers)
end

return M
