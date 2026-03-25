local dap = require "dap"

local M = {}
local uv = vim.uv or vim.loop

local function is_windows()
  return vim.fn.has "win32" == 1
end

local function python_executable(venv)
  if is_windows() then
    return vim.fs.joinpath(venv, "Scripts", "python.exe")
  end

  return vim.fs.joinpath(venv, "bin", "python")
end

function M.resolve_python()
  local venv_path = os.getenv "VIRTUAL_ENV"
  if venv_path then
    return python_executable(venv_path)
  end

  venv_path = os.getenv "CONDA_PREFIX"
  if venv_path then
    if is_windows() then
      return vim.fs.joinpath(venv_path, "python.exe")
    end

    return vim.fs.joinpath(venv_path, "bin", "python")
  end

  local root = vim.fn.getcwd()
  for _, folder in ipairs { "venv", ".venv", "env", ".env" } do
    local path = vim.fs.joinpath(root, folder)
    local stat = uv.fs_stat(path)
    if stat and stat.type == "directory" then
      return python_executable(path)
    end
  end

  return "python3"
end

local debugpy_python = python_executable(vim.fs.joinpath(vim.fn.stdpath "data", "mason", "packages", "debugpy", "venv"))

dap.adapters.python = function(cb, config)
  if config.request == "attach" then
    local connect = config.connect or config
    cb {
      type = "server",
      host = connect.host or "127.0.0.1",
      port = assert(connect.port, "`connect.port` is required for python attach"),
      options = {
        source_filetype = "python",
      },
    }
    return
  end

  cb {
    type = "executable",
    command = debugpy_python,
    args = { "-m", "debugpy.adapter" },
    options = {
      source_filetype = "python",
    },
  }
end

dap.adapters.debugpy = dap.adapters.python

return M
