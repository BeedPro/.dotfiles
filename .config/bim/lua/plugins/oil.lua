return {
  {
    "stevearc/oil.nvim",
    config = function()
      local oil = require "oil"
      oil.setup {
        delete_to_trash = true,
        view_options = {
          show_hidden = true,
        },
      }
    end,
    cmd = "Oil",
  },
}
