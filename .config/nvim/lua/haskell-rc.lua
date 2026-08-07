-- Use https://github.com/MrcJkb/haskell-tools.nvim for more features!

local lsp = require "lsp-rc"
local mason = require "mason-rc"
local quality = require "quality-rc"
local treesitter = require "treesitter-rc"
local dap = require "debugging-rc"

lsp.enable { "hls" }
mason.add {
  "haskell-language-server",
  "haskell-debug-adapter",
  "fourmolu",
  "hlint",
}

treesitter.add { "haskell" }

quality.formatters {
  haskell = { "fourmolu" },
}

quality.linters {
  haskell = { "hlint" },
}

dap.adapters.haskell = {
  type = "executable",
  command = "haskell-debug-adapter",
  args = { "--hackage-version=0.0.33.0" },
}

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
