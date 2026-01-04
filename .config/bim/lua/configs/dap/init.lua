local dap = require "dap"
local home = os.getenv "HOME"
local mason_home = home .. "/.local/share/nvim/mason"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = mason_home .. "/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.adapters.coreclr = {
  type = "executable",
  command = mason_home .. "/bin/netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    home .. "/.local/src/local-lua-debugger-vscode/extension/debugAdapter.js",
  },
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      c.extensionPath = home .. "/.local/src/local-lua-debugger-vscode/"
      on_config(c)
    else
      on_config(config)
    end
  end,
}

dap.configurations.cpp = {
  {
    name = "LLDB: Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    console = "integratedTerminal",
  },
  {
    name = "LLDB: Launch (args)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      return vim.split(vim.fn.input "Args: ", " +", { trimempty = true })
    end,
    console = "integratedTerminal",
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch .NET Core App",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
}

dap.configurations.lua = {
  {
    name = "Current file (local-lua-dbg, lua)",
    type = "local-lua",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = {
      lua = "lua5.1",
      file = "${file}",
    },
    args = {},
  },
}
