return {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip",
  },
  cmd = "Neogen",
  opts = function()
    return require "configs.neogen"
  end,
}
