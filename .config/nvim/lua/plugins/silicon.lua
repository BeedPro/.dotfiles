return {
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
      require("nvim-silicon").setup {
        font = "GohuFont 14 Nerd Font=25;",
        to_clipboard = true,
        -- theme = "DarkNeon",
        theme = os.getenv "HOME" .. "/.config/bat/themes/Catppuccin Mocha.tmTheme",
        pad_horiz = 0,
        pad_vert = 0,
        no_round_corner = true,
        no_window_controls = true,
        line_offset = function(args)
          return args.line1
        end,
      }
    end,
  },
}
