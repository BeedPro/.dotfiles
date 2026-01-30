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
      overrides = function()
        return {
          LspReferenceWrite = { underline = false },
        }
      end,
    }
    vim.cmd "colorscheme kanso"
  end,
}
