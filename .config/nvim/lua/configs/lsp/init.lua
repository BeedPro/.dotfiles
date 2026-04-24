local attach = require "configs.lsp.attach"
local client = require "configs.lsp.client"
local caps = require "configs.lsp.capabilities"

local autocmd = vim.api.nvim_create_autocmd

local M = {}

function M.setup()
  vim.diagnostic.config {
    underline = false,
  }

  autocmd("LspAttach", {
    callback = function(args)
      attach.on_attach(nil, args.buf)
    end,
  })

  vim.lsp.config("*", {
    capabilities = caps.capabilities,
    on_init = client.on_init,
  })

  local servers = {
    "lua_ls",
    "ty",
    "clangd",
    "tinymist",
    "ts_ls",
    "tailwindcss",
    "svelte",
    "gdscript",
    "biome",
    "texlab",
  }

  vim.lsp.enable(servers)
end

return M
