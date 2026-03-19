return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdLineEnter" },

  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      config = function(_, opts)
        require("luasnip").config.set_config(opts)
        require "configs.luasnip"
      end,
    },
  },

  opts_extend = { "sources.default" },

  opts = function()
    return require "configs.blink"
  end,
}
