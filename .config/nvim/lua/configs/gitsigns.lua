return {

  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "^" },
    changedelete = { text = "!" },
    untracked = { text = "?" },
  },

  signs_staged = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "^" },
    changedelete = { text = "!" },
    untracked = { text = "?" },
  },
  on_attach = function(bufnr)
    local gitsigns = require "gitsigns"
    require("mappings.gitsigns").on_attach(bufnr, gitsigns)
  end,
}
