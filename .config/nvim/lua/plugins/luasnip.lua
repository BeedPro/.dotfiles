return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  config = function()
    require "configs.luasnip"
  end,
}
