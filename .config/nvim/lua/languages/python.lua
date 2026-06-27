local lsp = require "lsprc"
local quality = require "quality"
local treesitter = require "treesitter-rc"
require "debugging"

lsp.enable { "ty" }
lsp.mason {
  "ty",
  "debugpy",
  "ruff",
  "djlint",
}

treesitter.add { "python" }

quality.formatters {
  python = { "ruff_format", "ruff_organize_imports" },
  djangohtml = { "djlint" },
  htmldjango = { "djlint" },
}

quality.linters {
  python = { "ruff" },
  htmldjango = { "djlint" },
}

vim.pack.add {
  "https://codeberg.org/mfussenegger/nvim-dap-python",
}

local function python_executable(venv)
  if vim.fn.has "win32" == 1 then
    return vim.fs.joinpath(venv, "Scripts", "python.exe")
  end
  return vim.fs.joinpath(venv, "bin", "python")
end

require("dap-python").setup(python_executable(vim.fs.joinpath(vim.fn.stdpath "data", "mason", "packages", "debugpy", "venv")))
