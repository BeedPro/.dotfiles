vim.pack.add {
  "https://github.com/danymat/neogen",
}

require("neogen").setup {
  snippet_engine = "luasnip",
  languages = {
    python = {
      template = {
        annotation_convention = "google_docstrings",
        sphinx = {
          { nil, '"""$1"""', { no_results = true, type = { "class", "func" } } },
          { nil, '"""$1', { no_results = true, type = { "file" } } },
          { nil, "", { no_results = true, type = { "file" } } },
          { nil, "$1", { no_results = true, type = { "file" } } },
          { nil, '"""', { no_results = true, type = { "file" } } },
          { nil, "", { no_results = true, type = { "file" } } },
          { nil, "# $1", { no_results = true, type = { "type" } } },
          { nil, '"""$1' },
          { nil, "" },
          {
            require("neogen.types.template").item.Parameter,
            ":param %s: $1",
            { after_each = ":type %s: $1", type = { "func" } },
          },
          {
            { require("neogen.types.template").item.Parameter, require("neogen.types.template").item.Type },
            ":param %s %s: $1",
            { required = require("neogen.types.template").item.Tparam, type = { "func" } },
          },
          { require("neogen.types.template").item.ClassAttribute, ":ivar %s: $1" },
          { require("neogen.types.template").item.Throw, ":raises %s: $1", { type = { "func" } } },
          {
            require("neogen.types.template").item.Return,
            ":returns: $1",
            { after_each = ":rtype: $1", type = { "func" } },
          },
          {
            require("neogen.types.template").item.ReturnTypeHint,
            ":returns: $1",
            { after_each = ":rtype: %s", type = { "func" } },
          },
          { nil, '"""' },
        },
      },
    },
  },
}

vim.keymap.set("n", "<leader>ca", function()
  require("neogen").generate()
end, { desc = "Generate code annotation" })
