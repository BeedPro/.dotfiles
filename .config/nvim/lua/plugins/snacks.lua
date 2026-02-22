return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      scroll = { enabled = false },
      indent = {
        enabled = false,
        animate = {
          enabled = false,
        },
        scope = {
          enabled = false,
        },
      },
      styles = {
        notification = {
          border = "single",
        },
      },
    },
  },
}
