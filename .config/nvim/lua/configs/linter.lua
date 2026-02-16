local lint = require "lint"

lint.linters_by_ft = {
  javascript = { "biomejs" },
  typescript = { "biomejs" },
  python = { "ruff" },
  htmldjango = { "djlint" },
}

local autocmd = vim.api.nvim_create_autocmd
local events = { "BufWritePost", "BufReadPost", "InsertLeave", "BufEnter" }

autocmd(events, {
  callback = function()
    require("lint").try_lint()
  end,
})
