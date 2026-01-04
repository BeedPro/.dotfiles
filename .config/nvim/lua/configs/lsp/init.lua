local attach = require "configs.lsp.attach"
local client = require "configs.lsp.client"
local caps = require "configs.lsp.capabilities"

local autocmd = vim.api.nvim_create_autocmd

local M = {}

function M.setup()
  autocmd("LspAttach", {
    callback = function(args)
      attach.on_attach(_, args.buf)
    end,
  })

  -- Default config for all servers
  vim.lsp.config("*", {
    capabilities = caps.capabilities,
    on_init = client.on_init,
  })

  local servers = { "lua_ls", "pyright", "clangd", "tinymist", "roslyn", "tailwindcss", "svelte" }

  for _, server in ipairs(servers) do
    local ok, config = pcall(require, "configs.lsp.servers." .. server)

    if ok then
      vim.lsp.config(server, config)
    else
      vim.lsp.config(server, {})
    end
  end

  vim.lsp.enable(servers)
end

return M
