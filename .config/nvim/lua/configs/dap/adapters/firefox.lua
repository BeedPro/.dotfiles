local dap = require "dap"

local mason_home = vim.fs.joinpath(vim.fn.stdpath "data", "mason")

dap.adapters.firefox = {
  type = "executable",
  command = "node",
  args = {
    vim.fs.joinpath(mason_home, "packages", "firefox-debug-adapter", "dist", "adapter.bundle.js"),
  },
}
