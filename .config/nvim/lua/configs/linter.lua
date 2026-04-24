local lint = require "lint"

lint.linters_by_ft = {
  css = { "biomejs" },
  html = { "biomejs" },
  javascript = { "biomejs" },
  javascriptreact = { "biomejs" },
  json = { "biomejs" },
  python = { "ruff" },
  haskell = { "hlint" },
  htmldjango = { "djlint" },
  svelte = { "biomejs" },
  typescript = { "biomejs" },
  typescriptreact = { "biomejs" },
  gdscript = { "gdlint" },
}

local autocmd = vim.api.nvim_create_autocmd
local events = { "BufWritePost", "BufReadPost", "InsertLeave", "BufEnter" }

autocmd(events, {
  callback = function()
    require("lint").try_lint()
  end,
})
