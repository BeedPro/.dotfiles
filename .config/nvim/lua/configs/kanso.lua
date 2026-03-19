require("kanso").setup {
  italics = false,
  undercurl = false,
  background = {
    dark = "zen",
    light = "pearl",
  },
  overrides = function(colors)
    return {
      -- treesitter
      ["@markup.underline"] = { underline = false, undercurl = false },
      ["@string.special.url"] = { underline = false, undercurl = false },

      -- builtin
      Underlined = { underline = false, undercurl = false },

      -- spell
      SpellBad = { underline = false, undercurl = true },
      SpellCap = { underline = false, undercurl = true },
      SpellLocal = { underline = false, undercurl = true },
      SpellRare = { underline = false, undercurl = true },

      -- lsp
      LspReferenceWrite = { underline = false, undercurl = false },

      -- plugins
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

vim.cmd "colorscheme kanso"
