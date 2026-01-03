local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "[G]oto [D]eclaration")
  map("n", "gd", vim.lsp.buf.definition, opts "[G]oto [d]efinition")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "[W]orkspace [A]dd")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "[W]orkspace [R]emove")
  map("n", "grn", vim.lsp.buf.rename, opts "[R]e[n]ame")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "[W]orkspace [L]ist")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Goto type definition")
  map("n", "<leader>ra", require "mappings.renamer", opts "[R]ename [A]ll")
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts "[C]ode [A]ction")
end

-- disable semanticTokens
M.on_init = function(client, _)
  if vim.fn.has "nvim-0.11" ~= 1 then
    if client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  else
    if client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
end

return M
