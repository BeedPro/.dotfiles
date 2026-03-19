return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = function()
    return require "configs.treesitter"
  end,
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
