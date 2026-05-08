local dap = require "dap"

local mason_home = vim.fs.joinpath(vim.fn.stdpath "data", "mason")
local dlv = vim.fs.joinpath(mason_home, "bin", "dlv")

dap.adapters.delve = function(callback, config)
  if config.mode == "remote" and config.request == "attach" then
    callback {
      type = "server",
      host = config.host or "127.0.0.1",
      port = config.port or "38697",
    }
    return
  end

  callback {
    type = "server",
    port = "${port}",
    executable = {
      command = dlv,
      args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
      detached = vim.fn.has "win32" == 0,
    },
  }
end
