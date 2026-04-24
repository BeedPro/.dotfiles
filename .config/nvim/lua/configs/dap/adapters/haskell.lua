local dap = require "dap"

local haskell_debug_adapter = vim.fn.stdpath "data" .. "/mason/bin" .. "/haskell-debug-adapter"

dap.adapters.haskell = {
  type = "executable",
  command = haskell_debug_adapter,
}
