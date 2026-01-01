return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000, 
  config = function()
    require("catppuccin").setup({
      flavour = "auto", 
      background = {
        light = "latte",
        dark = "mocha",
      },
      no_italic = true,
      transparent_background = false,
      term_colors = true,
      integrations = {
        treesitter = true,
        gitsigns = true,
        telescope = true,
        nvimtree = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
