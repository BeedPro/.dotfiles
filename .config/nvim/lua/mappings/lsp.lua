local M = {}
local map = vim.keymap.set

function M.attach(bufnr)
  map("n", "grr", function()
    require("fzf-lua").lsp_references()
  end, { buffer = bufnr, desc = "LSP: find references" })
  map("n", "gri", function()
    require("fzf-lua").lsp_implementations()
  end, { buffer = bufnr, desc = "LSP: find implementations" })
  map("n", "grt", function()
    require("fzf-lua").lsp_typedefs()
  end, { buffer = bufnr, desc = "LSP: type definitions" })
  map("n", "gO", function()
    require("fzf-lua").lsp_document_symbols()
  end, { buffer = bufnr, desc = "LSP: document symbols" })
  map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
  map("n", "gd", function()
    require("fzf-lua").lsp_definitions()
  end, { buffer = bufnr, desc = "Go to definition" })
end

return M
