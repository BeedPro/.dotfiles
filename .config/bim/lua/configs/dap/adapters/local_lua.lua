local dap = require "dap"

local home = os.getenv "HOME"

dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    home .. "/.local/src/local-lua-debugger-vscode/extension/debugAdapter.js",
  },
  enrich_config = function(config, on_config)
    if not config.extensionPath then
      local c = vim.deepcopy(config)
      c.extensionPath = home .. "/.local/src/local-lua-debugger-vscode/"
      on_config(c)
    else
      on_config(config)
    end
  end,
}
