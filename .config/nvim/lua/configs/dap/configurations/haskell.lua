local ghci_dap = vim.fn.stdpath "data" .. "mason/bin" .. "/ghci-dap"
if vim.fn.executable(ghci_dap) ~= 1 then
  ghci_dap = vim.fn.exepath "ghci-dap"
end

if ghci_dap == "" then
  ghci_dap = "ghci-dap"
end

return {
  {
    type = "haskell",
    request = "launch",
    name = "Debug",
    workspace = "${workspaceFolder}",
    startup = "${file}",
    stopOnEntry = true,
    logFile = vim.fn.stdpath "data" .. "/haskell-dap.log",
    logLevel = "DEBUG",
    ghciEnv = vim.empty_dict(),
    ghciPrompt = "ghci> ",
    ghciInitialPrompt = "ghci> ",
    ghciCmd = "stack ghci --with-ghc="
      .. ghci_dap
      .. " --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
  },
}
