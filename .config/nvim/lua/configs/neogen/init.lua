return {
  snippet_engine = "luasnip",
  languages = {
    haskell = {
      parent = {
        func = { "function", "bind", "signature" },
      },
      data = {
        func = {
          ["function|bind|signature"] = {
            ["0"] = {
              extract = function()
                return {}
              end,
            },
          },
        },
      },
      template = {
        annotation_convention = "haddock",
        use_default_comment = false,
        haddock = require "configs.neogen.templates.haddock",
      },
    },
    python = {
      template = {
        annotation_convention = "google_docstrings",
        sphinx = require "configs.neogen.templates.sphinx",
      },
    },
  },
}
