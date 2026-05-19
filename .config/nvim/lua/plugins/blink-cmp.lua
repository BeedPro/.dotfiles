return {
  "saghen/blink.cmp",
  dependencies = {
    "saghen/blink.lib",
    "rafamadriz/friendly-snippets",
  },
  build = function()
    require("blink.cmp").build():wait(60000)
  end,
  event = { "InsertEnter", "CmdLineEnter" },
  opts = require "configs.blink-cmp",
}
