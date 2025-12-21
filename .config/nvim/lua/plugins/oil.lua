return {
  {
    "stevearc/oil.nvim",
    config = function()
      require "configs.oil"
    end,
    cmd = "Oil",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },
}
