---@class snacks.Config
local opts = {
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  indent = { enabled = false },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      border = "single",
    },
  },
}

return opts
