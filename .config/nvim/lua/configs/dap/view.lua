return {
  winbar = {
    sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
    default_section = "scopes",
    controls = { enabled = true },
  },
  windows = {
    terminal = {
      size = 0.40,
      position = "right",
      hide = { "delve" },
    },
  },
  auto_toggle = true,
}
