return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave", "BufEnter" },
  config = function()
    require "configs.nvim-lint"
  end,
}
