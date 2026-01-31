return {
  "webhooked/kanso.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanso").setup {
      italics = false,
      undercurl = false,
      background = {
        dark = "zen",
        light = "pearl",
      },
      overrides = function(colors)
        return {
          LspReferenceWrite = { underline = false },
          WinSeparator = { fg = colors.palette.gray3 },
        }
      end,
    }
    vim.cmd "colorscheme kanso"
  end,
}
