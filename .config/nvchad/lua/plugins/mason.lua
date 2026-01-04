return {
  "mason-org/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts = function()
    local opts = require "nvchad.configs.mason"
    opts.registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    }
    return opts
  end,
}
