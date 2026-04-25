local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
  htmldjango = { "djlint" },
  c = { "cpplint" },
  cpp = { "cpplint" },
  haskell = { "hlint" },
  typescript = { "biomejs" },
  typescriptreact = { "biomejs" },
  javascript = { "biomejs" },
  javascriptreact = { "biomejs" },
  json = { "biomejs" },
  html = { "biomejs" },
  css = { "biomejs" },
  svelte = { "biomejs" },
  gdscript = { "gdlint" },
}

local autocmd = vim.api.nvim_create_autocmd
local events = { "BufWritePost", "BufReadPost", "InsertLeave", "BufEnter" }

autocmd(events, {
  callback = function()
    require("lint").try_lint()
  end,
})
