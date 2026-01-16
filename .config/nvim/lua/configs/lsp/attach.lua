local M = {}
local map = vim.keymap.set
local lspbuf = vim.lsp.buf
local telescope = require "telescope.builtin"

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  map("n", "grn", require "mappings.renamer", opts "[R]e[n]ame")
  map("n", "gra", lspbuf.code_action, opts "[C]ode [A]ction")
  map("n", "grr", telescope.lsp_references, opts "[C]ode [R]eferences")
  map("n", "gri", telescope.lsp_implementations, opts "[C]ode [I]mplementation")
  map("n", "grt", telescope.lsp_type_definitions, opts "[C]ode [T]ype Definition")
  map("n", "gO", telescope.lsp_document_symbols, opts "[C]ode Symb[O]ls")
  map("n", "gD", lspbuf.declaration, opts "[G]oto [D]eclaration")
  map("n", "gd", telescope.lsp_definitions, opts "[G]oto [d]efinition")
end

return M
