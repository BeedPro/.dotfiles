local dap = require "dap"

local haskell_debug_adapter = vim.fn.stdpath "data" .. "mason/bin" .. "/haskell-debug-adapter"
if vim.fn.executable(haskell_debug_adapter) ~= 1 then
  haskell_debug_adapter = vim.fn.exepath "haskell-debug-adapter"
end

if haskell_debug_adapter == "" then
  haskell_debug_adapter = "haskell-debug-adapter"
end

dap.adapters.haskell = {
  type = "executable",
  command = haskell_debug_adapter,
}
