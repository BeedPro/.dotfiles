return {
  {
    type = "haskell",
    request = "launch",
    name = "Debug",
    workspace = "${workspaceFolder}",
    startup = "${file}",
    stopOnEntry = true,
    logFile = vim.fn.stdpath "data" .. "/haskell-dap.log",
    logLevel = "WARNING",
    ghciEnv = vim.empty_dict(),
    ghciPrompt = "ghci> ",
    ghciInitialPrompt = "ghci> ",
    ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
  },
}
