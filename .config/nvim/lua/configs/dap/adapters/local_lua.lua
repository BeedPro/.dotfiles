local dap = require "dap"

local home = os.getenv "HOME"
local mason_home = home .. "/.local/share/nvim/mason"
local local_lua_package = mason_home .. "/packages/local-lua-debugger-vscode/extension"

dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    local_lua_package .. "/extension/debugAdapter.js",
  },
  enrich_config = function(config, on_config)
    if not config.extensionPath then
      local c = vim.deepcopy(config)
      c.extensionPath = local_lua_package
      on_config(c)
    else
      on_config(config)
    end
  end,
}
