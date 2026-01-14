local actions = require "telescope.actions"

return {
  defaults = {
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",

    border = true,
    borderchars = {
      prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },

    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },

    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
  },
}
