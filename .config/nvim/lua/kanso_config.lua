vim.pack.add {
  "https://github.com/webhooked/kanso.nvim",
}

require("kanso").setup {
  italics = false,
  undercurl = false,
  background = {
    dark = "zen",
    light = "pearl",
  },
  overrides = function(colors)
    return {
      ["@markup.underline"] = { underline = false, undercurl = false },
      ["@string.special.url"] = { underline = false, undercurl = false },
      Underlined = { underline = false, undercurl = false },
      SpellBad = { underline = false, undercurl = true },
      SpellCap = { underline = false, undercurl = true },
      SpellLocal = { underline = false, undercurl = true },
      SpellRare = { underline = false, undercurl = true },
      LspReferenceWrite = { underline = false, undercurl = false },
      IndentBlanklineContextStart = { underline = false, undercurl = false },
      ["@ibl.scope.underline.1"] = { underline = false, undercurl = false },
      MiniCompletionActiveParameter = { underline = false, undercurl = false },
      MiniCursorword = { underline = false, undercurl = false },
      MiniCursorwordCurrent = { underline = false, undercurl = false },
      NeotestFocused = { underline = false, undercurl = false },
      WinSeparator = { fg = colors.palette.gray3 },
    }
  end,
}

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("DapColorScheme", { clear = true }),
  callback = function()
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "debugPC", {
        bg = require("kanso.colors").setup().theme.ui.bg_dim,
      })
    end)
  end,
})
