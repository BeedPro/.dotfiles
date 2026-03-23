return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  config = function()
    require "configs.treesitter"
  end,
}
