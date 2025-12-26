-- For more info see: https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig

local M = {}

M.base46 = {
  theme = "one_light",
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  telescope = { style = "borderless" },
  statusline = {
    theme = "vscode_colored",
  },
  tabufline = {
    enabled = false,
    order = { "buffers", "tabs" },
  },
}

M.mason = {
  pkgs = {
    -- LSP
    "clangd",
    "pyright",
    "jdtls",
    "lua-language-server",
    "roslyn",
    "tinymist",
    -- DAP
    "codelldb",
    "debugpy",
    "java-debug-adapter",
    "java-test",
    "netcoredbg",
    -- Linter
    "mypy",
    "ruff",
    "djlint",
    -- Formatters
    "prettypst",
    "black",
    "clang-format",
    "csharpier",
    "prettier",
    "prettierd",
    "stylua",
  },
}

return M
