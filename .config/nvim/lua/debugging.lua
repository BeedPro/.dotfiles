vim.pack.add {
  "https://github.com/mfussenegger/nvim-dap",
  "https://codeberg.org/mfussenegger/nvim-dap-python",
  "https://github.com/igorlfs/nvim-dap-view",
}

local dap = require("dap")

local function python_executable(venv)
  if vim.fn.has "win32" == 1 then
    return vim.fs.joinpath(venv, "Scripts", "python.exe")
  end
  return vim.fs.joinpath(venv, "bin", "python")
end

vim.fn.sign_define("DapStopped", { text = "> ", texthl = "SignColumn", linehl = "debugPC" })

require("dap-python").setup(python_executable(vim.fs.joinpath(vim.fn.stdpath "data", "mason", "packages", "debugpy", "venv")))

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

require("dap-view").setup {
  winbar = {
    sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
    default_section = "scopes",
    controls = { enabled = true },
  },
  windows = {
    terminal = {
      size = 0.40,
      position = "right",
      hide = { "delve" },
    },
  },
  auto_toggle = true,
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
vim.keymap.set("n", "<leader>dw", function()
  require("dap-view").add_expr()
end, { desc = "Debug: add watch expression" })
vim.keymap.set("n", "<leader>dk", function()
  require("dap-view").hover()
end, { desc = "Debug: hover value" })
vim.keymap.set("n", "<leader>dv", function()
  require("dap-view").virtual_text_toggle()
end, { desc = "Debug: toggle virtual text" })
