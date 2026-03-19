return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdLineEnter" },

  opts_extend = { "sources.default" },

  opts = require "configs.blink",
}
