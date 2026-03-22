return {
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
      host = host ~= "" and host or "localhost"
      local port = vim.fn.input "Port [3000]: "
      port = port ~= "" and port or "3000"
      return "http://" .. host .. ":" .. port
    end,
    webRoot = "${workspaceFolder}",
    firefoxExecutable = "/usr/bin/firefox",
  },
}
