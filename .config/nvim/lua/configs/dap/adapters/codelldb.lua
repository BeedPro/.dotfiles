local dap = require "dap"

local mason_home = vim.fs.joinpath(vim.fn.stdpath "data", "mason")

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fs.joinpath(mason_home, "bin", "codelldb"),
    args = { "--port", "${port}" },
  },
}
