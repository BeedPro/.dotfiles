local ghci_dap = vim.fn.stdpath "data" .. "/mason/bin" .. "/ghci-dap"

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
    ghciCmd = "stack ghci --with-ghc=" .. ghci_dap .. " --main-is TARGET --ghci-options -fprint-evld-with-show",
  },
}
