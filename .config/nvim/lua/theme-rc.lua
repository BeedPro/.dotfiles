vim.pack.add {
  "https://github.com/miikanissi/modus-themes.nvim",
}

require("modus-themes").setup {
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  },
}

vim.cmd.colorscheme "modus"
