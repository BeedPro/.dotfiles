require("catppuccin").setup {
  flavour = "auto",
  background = {
    light = "latte",
    dark = "mocha",
  },
  styles = {
    comments = { "italic" },
    conditionals = {},
  },
  transparent_background = false,
  term_colors = true,
  integrations = {
    treesitter = true,
    gitsigns = true,
    telescope = true,
    nvimtree = true,
  },
  custom_highlights = function(colors)
    return {
      WinSeparator = { fg = colors.surface1 },
    }
  end,
}

vim.cmd.colorscheme "catppuccin"
