local small_window_max_cols = 120
local small_window_max_lines = 35
local preview_layout = "flex"
local preview_flip_columns = 120
local preview_vertical = "down:45%"
local preview_horizontal = "right:55%"
local keymaps_preview_layout = "vertical"
local keymaps_preview_vertical = "down:60%"

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
        layout = preview_layout,
        flip_columns = preview_flip_columns,
        vertical = preview_vertical,
        horizontal = preview_horizontal,
        border = "single",
      },
    }
  end,
  files = {
    cwd_prompt = false,
    winopts = {
      preview = {
        layout = preview_layout,
        flip_columns = preview_flip_columns,
      },
    },
  },
  grep = {
    winopts = {
      preview = {
        layout = preview_layout,
        flip_columns = preview_flip_columns,
      },
    },
  },
  keymaps = {
    winopts = {
      preview = {
        layout = keymaps_preview_layout,
        vertical = keymaps_preview_vertical,
      },
    },
  },
}
