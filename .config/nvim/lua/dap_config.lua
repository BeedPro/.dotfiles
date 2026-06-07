vim.pack.add {
  "https://github.com/mfussenegger/nvim-dap",
}

local dap = require("dap")

local function python_executable(venv)
  if vim.fn.has "win32" == 1 then
    return vim.fs.joinpath(venv, "Scripts", "python.exe")
  end
  return vim.fs.joinpath(venv, "bin", "python")
end

local function project_python_path()
  if os.getenv "VIRTUAL_ENV" then
    return python_executable(os.getenv "VIRTUAL_ENV")
  end
  if os.getenv "CONDA_PREFIX" then
    if vim.fn.has "win32" == 1 then
      return vim.fs.joinpath(os.getenv "CONDA_PREFIX", "python.exe")
    end
    return vim.fs.joinpath(os.getenv "CONDA_PREFIX", "bin", "python")
  end
  for _, folder in ipairs { "venv", ".venv", "env", ".env" } do
    if (vim.uv or vim.loop).fs_stat(vim.fs.joinpath(vim.fn.getcwd(), folder)) then
      return python_executable(vim.fs.joinpath(vim.fn.getcwd(), folder))
    end
  end
  return "python3"
end

vim.fn.sign_define("DapStopped", { text = "> ", texthl = "SignColumn", linehl = "debugPC" })

dap.adapters.python = function(cb, config)
  if config.request == "attach" then
    cb {
      type = "server",
      host = (config.connect or config).host or "127.0.0.1",
      port = assert((config.connect or config).port, "`connect.port` is required for python attach"),
      options = {
        source_filetype = "python",
      },
    }
    return
  end

  cb {
    type = "executable",
    command = python_executable(vim.fs.joinpath(vim.fn.stdpath "data", "mason", "packages", "debugpy", "venv")),
    args = { "-m", "debugpy.adapter" },
    options = {
      source_filetype = "python",
    },
  }
end

dap.adapters.debugpy = dap.adapters.python

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fs.joinpath(vim.fn.stdpath "data", "mason", "bin", "codelldb"),
    args = { "--port", "${port}" },
  },
}

dap.adapters.haskell = {
  type = "executable",
  command = "haskell-debug-adapter",
  args = { "--hackage-version=0.0.33.0" },
}

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = vim.fs.joinpath(vim.fn.stdpath "data", "mason", "bin", "js-debug-adapter"),
    args = { "${port}" },
  },
}

dap.adapters.firefox = {
  type = "executable",
  command = "node",
  args = {
    vim.fs.joinpath(vim.fn.stdpath "data", "mason", "packages", "firefox-debug-adapter", "dist", "adapter.bundle.js"),
  },
}

dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    console = "integratedTerminal",
    pythonPath = project_python_path,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file (args)",
    program = "${file}",
    args = function()
      if require("dap.utils").splitstr and vim.fn.has "nvim-0.10" == 1 then
        return require("dap.utils").splitstr(vim.fn.input "Arguments: ")
      end
      return vim.split(vim.fn.input "Arguments: ", " +")
    end,
    console = "integratedTerminal",
    pythonPath = project_python_path,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach process",
    connect = function()
      local host = vim.fn.input "Host [127.0.0.1]: "
      return {
        host = host ~= "" and host or "127.0.0.1",
        port = tonumber(vim.fn.input "Port [5678]: ") or 5678,
      }
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
    pythonPath = project_python_path,
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. package.config:sub(1, 1), "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    console = "integratedTerminal",
  },
  {
    name = "Launch file (args)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
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

dap.configurations.haskell = {
  {
    type = "haskell",
    request = "launch",
    name = "Debug",
    workspace = "${workspaceFolder}",
    startup = "${file}",
    stopOnEntry = true,
    logFile = vim.fs.joinpath(vim.fn.stdpath "data", "haskell-dap.log"),
    logLevel = "WARNING",
    ghciEnv = vim.empty_dict(),
    ghciPrompt = "ghci> ",
    ghciInitialPrompt = "ghci> ",
    ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
  },
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach process",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
  {
    type = "firefox",
    request = "launch",
    name = "Launch browser",
    reAttach = true,
    url = function()
      local host = vim.fn.input "Host [localhost]: "
      local port = vim.fn.input "Port [3000]: "
      return "http://" .. (host ~= "" and host or "localhost") .. ":" .. (port ~= "" and port or "3000")
    end,
    webRoot = "${workspaceFolder}",
    firefoxExecutable = vim.fn.exepath "firefox" ~= "" and vim.fn.exepath "firefox" or "firefox",
  },
}

dap.configurations.javascriptreact = dap.configurations.javascript
dap.configurations.typescript = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.javascript
dap.configurations.svelte = dap.configurations.javascript

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
  },
}

vim.keymap.set("n", "<Right>", function()
  dap.step_into()
end, { desc = "Debug: step into" })
vim.keymap.set("n", "<Down>", function()
  dap.step_over()
end, { desc = "Debug: step over" })
vim.keymap.set("n", "<Left>", function()
  dap.step_out()
end, { desc = "Debug: step out" })
vim.keymap.set("n", "<Up>", function()
  dap.restart_frame()
end, { desc = "Debug: restart frame" })
vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, { desc = "Debug: toggle breakpoint" })
vim.keymap.set("n", "<leader>dr", function()
  dap.continue()
end, { desc = "Debug: run or continue" })
vim.keymap.set("n", "<leader>dR", function()
  dap.restart()
end, { desc = "Debug: restart session" })
vim.keymap.set("n", "<leader>dl", function()
  dap.run_last()
end, { desc = "Debug: run last configuration" })
vim.keymap.set("n", "<leader>dt", function()
  dap.terminate()
end, { desc = "Debug: terminate session" })
