local dap = require "dap"

local mason_home = vim.fs.joinpath(vim.fn.stdpath "data", "mason")
local local_lua_package = vim.fs.joinpath(mason_home, "packages", "local-lua-debugger-vscode", "extension")

dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    vim.fs.joinpath(local_lua_package, "extension", "debugAdapter.js"),
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
