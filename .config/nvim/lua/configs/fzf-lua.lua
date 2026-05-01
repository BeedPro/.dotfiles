return {
  { "telescope", "hide" },
  defaults = {
    file_icons = false,
    git_icons = false,
    color_icons = false,
  },
  fzf_colors = true,
  fzf_opts = {
    ["--layout"] = "reverse",
  },
  winopts = {
    height = 0.8,
    width = 0.9,
    row = 0.5,
    col = 0.5,
    border = "single",
    preview = {
      layout = "horizontal",
      horizontal = "right:55%",
      border = "single",
    },
  },
}
