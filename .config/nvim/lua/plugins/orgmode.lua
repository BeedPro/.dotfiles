return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  cmd = "Org",
  ft = { "org" },
  config = function()
    require "configs.orgmode"
  end,
}
