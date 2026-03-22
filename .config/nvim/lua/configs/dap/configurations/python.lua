local python_adapter = require "configs.dap.adapters.python"

return {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    console = "integratedTerminal",
    pythonPath = python_adapter.resolve_python,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file (args)",
    program = "${file}",
    args = function()
      local args_string = vim.fn.input "Arguments: "
      local utils = require "dap.utils"
      if utils.splitstr and vim.fn.has "nvim-0.10" == 1 then
        return utils.splitstr(args_string)
      end

      return vim.split(args_string, " +")
    end,
    console = "integratedTerminal",
    pythonPath = python_adapter.resolve_python,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach process",
    connect = function()
      local host = vim.fn.input "Host [127.0.0.1]: "
      host = host ~= "" and host or "127.0.0.1"
      local port = tonumber(vim.fn.input "Port [5678]: ") or 5678
      return { host = host, port = port }
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Run doctest",
    module = "doctest",
    args = { "${file}" },
    noDebug = true,
    console = "integratedTerminal",
    pythonPath = python_adapter.resolve_python,
  },
}
