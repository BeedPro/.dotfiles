return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdLineEnter" },
  dependencies = { "ribru17/blink-cmp-spell" },

  opts_extend = { "sources.default" },

  opts = require "configs.blink-cmp",
}
