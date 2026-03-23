return {
  "webhooked/kanso.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require "configs.kanso"
  end,
}
