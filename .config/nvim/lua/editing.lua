vim.pack.add {
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/danymat/neogen",
}

require("mini.sessions").setup {
  force = { read = false, write = true, delete = true },
}

require("mini.hipatterns").setup {
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color { style = "inline", inline_text = "█ " },
  },
}

local parsers = {
  "c",
  "cpp",
  "css",
  "gdscript",
  "haskell",
  "htmldjango",
  "html",
  "javascript",
  "json",
  "lua",
  "python",
  "markdown",
  "markdown_inline",
  "query",
  "svelte",
  "tsx",
  "typescript",
  "typst",
  "vim",
  "vimdoc",
  "yaml",
  "prolog",
  "bash",
}

require("nvim-treesitter").install(parsers)

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

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("MiniHipatternsColorScheme", { clear = true }),
  callback = function()
    vim.schedule(function()
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "MiniHipatternsFixme", link = false })
      if ok and type(hl) == "table" and (hl.bg or hl.fg) then
        vim.api.nvim_set_hl(0, "MiniHipatternsFixme", {
          fg = hl.bg or hl.fg,
          bg = "NONE",
          bold = hl.bold,
          italic = hl.italic,
          underline = hl.underline,
          undercurl = hl.undercurl,
          strikethrough = hl.strikethrough,
          nocombine = hl.nocombine,
        })
      end
      ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "MiniHipatternsHack", link = false })
      if ok and type(hl) == "table" and (hl.bg or hl.fg) then
        vim.api.nvim_set_hl(0, "MiniHipatternsHack", {
          fg = hl.bg or hl.fg,
          bg = "NONE",
          bold = hl.bold,
          italic = hl.italic,
          underline = hl.underline,
          undercurl = hl.undercurl,
          strikethrough = hl.strikethrough,
          nocombine = hl.nocombine,
        })
      end
      ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "MiniHipatternsTodo", link = false })
      if ok and type(hl) == "table" and (hl.bg or hl.fg) then
        vim.api.nvim_set_hl(0, "MiniHipatternsTodo", {
          fg = hl.bg or hl.fg,
          bg = "NONE",
          bold = hl.bold,
          italic = hl.italic,
          underline = hl.underline,
          undercurl = hl.undercurl,
          strikethrough = hl.strikethrough,
          nocombine = hl.nocombine,
        })
      end
      ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "MiniHipatternsNote", link = false })
      if ok and type(hl) == "table" and (hl.bg or hl.fg) then
        vim.api.nvim_set_hl(0, "MiniHipatternsNote", {
          fg = hl.bg or hl.fg,
          bg = "NONE",
          bold = hl.bold,
          italic = hl.italic,
          underline = hl.underline,
          undercurl = hl.undercurl,
          strikethrough = hl.strikethrough,
          nocombine = hl.nocombine,
        })
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterFileTypeStart", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_user_command("TSInstallAll", function()
  require("nvim-treesitter").install(parsers)
end, {
  desc = "Install predefined Treesitter parsers",
})
