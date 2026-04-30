local caps = require "configs.lsp.capabilities"

local M = {}

function M.setup()
  vim.diagnostic.config {
    underline = false,
  }

  vim.lsp.config("*", {
    capabilities = caps.capabilities,
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
end

return M
