local small_window_max_cols = 120
local small_window_max_lines = 35

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
  winopts = function()
    local small = vim.o.columns < small_window_max_cols or vim.o.lines < small_window_max_lines

    return {
      height = 0.8,
      width = 0.9,
      row = 0.5,
      col = 0.5,
      border = "single",
      preview = {
        hidden = small,
        layout = "flex",
        flip_columns = 120,
        vertical = "down:45%",
        horizontal = "right:55%",
        border = "single",
      },
    }
  end,
  files = {
    cwd_prompt = false,
  },
  oldfiles = {
    cwd_only = true,
  },
  keymaps = {
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:60%",
      },
    },
  },
}
