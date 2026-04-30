local M = {}
local map = vim.keymap.set

function M.attach(bufnr)
  map("n", "grr", function()
    require("fzf-lua").lsp_references()
  end, { buffer = bufnr, desc = "[C]ode [R]eferences" })
  map("n", "gri", function()
    require("fzf-lua").lsp_implementations()
  end, { buffer = bufnr, desc = "[C]ode [I]mplementation" })
  map("n", "grt", function()
    require("fzf-lua").lsp_typedefs()
  end, { buffer = bufnr, desc = "[C]ode [T]ype Definition" })
  map("n", "gO", function()
    require("fzf-lua").lsp_document_symbols()
  end, { buffer = bufnr, desc = "[C]ode Symb[O]ls" })
  map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "[G]oto [D]eclaration" })
  map("n", "gd", function()
    require("fzf-lua").lsp_definitions()
  end, { buffer = bufnr, desc = "[G]oto [d]efinition" })
end

return M
