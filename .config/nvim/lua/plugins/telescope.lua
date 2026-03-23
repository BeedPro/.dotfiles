return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  opts = function()
    return require "configs.telescope"
  end,
}
