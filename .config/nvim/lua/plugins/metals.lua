return {
  "scalameta/nvim-metals",
  ft = { "scala", "sbt" },

  config = function()
    require "configs.metals"
  end,
}
