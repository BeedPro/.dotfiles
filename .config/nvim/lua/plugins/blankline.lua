return {
  "lukas-reineke/indent-blankline.nvim",
  event = "User FilePost",
  config = function()
    local hooks = require "ibl.hooks"

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblChar", {
        fg = "#383747",
      })

      vim.api.nvim_set_hl(0, "IblScopeChar", {
        fg = "#383747",
      })
    end)

    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

    require("ibl").setup {
      indent = {
        highlight = "IblChar",
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = {
        highlight = "IblScopeChar",
        show_start = false,
        show_end = false,
      },
    }
  end,
}
