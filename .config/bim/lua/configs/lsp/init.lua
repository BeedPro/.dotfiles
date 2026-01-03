local attach = require "configs.lsp.attach"
local client = require "configs.lsp.init_client"
local caps = require "configs.lsp.capabilities"
local init = require "configs.lsp.init_client"

local autocmd = vim.api.nvim_create_autocmd

local M = {}

M.on_attach = attach
M.on_init = init
M.capabilities = caps

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

  local servers = { "lua_ls", "pyright" }

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
