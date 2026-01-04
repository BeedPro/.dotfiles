return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opt = function()
    require "configs.catppuccin"
  end,
}
