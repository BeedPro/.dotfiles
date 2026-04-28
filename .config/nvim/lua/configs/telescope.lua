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
      },
    },

    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
  },
}
