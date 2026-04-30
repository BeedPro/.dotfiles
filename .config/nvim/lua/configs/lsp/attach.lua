local M = {}
local map = vim.keymap.set
local telescope = require "telescope.builtin"

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  map("n", "grr", telescope.lsp_references, { buffer = bufnr, desc = "[C]ode [R]eferences" })
  map("n", "gri", telescope.lsp_implementations, { buffer = bufnr, desc = "[C]ode [I]mplementation" })
  map("n", "grt", telescope.lsp_type_definitions, { buffer = bufnr, desc = "[C]ode [T]ype Definition" })
  map("n", "gO", telescope.lsp_document_symbols, { buffer = bufnr, desc = "[C]ode Symb[O]ls" })
  map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "[G]oto [D]eclaration" })
  map("n", "gd", telescope.lsp_definitions, { buffer = bufnr, desc = "[G]oto [d]efinition" })
end

return M
