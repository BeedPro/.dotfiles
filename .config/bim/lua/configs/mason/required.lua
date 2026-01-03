local M = {}

-- Always install these
M.pkgs = {
  "lua-language-server",
  "stylua",
  "pyright",
}

-- Never install these
M.skip = {
  -- "clangd",
}

return M
