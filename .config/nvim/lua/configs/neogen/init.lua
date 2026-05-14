return {
  snippet_engine = "luasnip",
  languages = {
    python = {
      template = {
        annotation_convention = "google_docstrings",
        sphinx = require "configs.neogen.templates.sphinx",
      },
    },
  },
}
