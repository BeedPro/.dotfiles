vim.pack.add {
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
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
  "groovy",
  "haskell",
  "htmldjango",
  "html",
  "java",
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
