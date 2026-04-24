local opt_local = vim.opt_local

opt_local.spell = true
opt_local.spelllang = "en_gb"
opt_local.colorcolumn = "80"

vim.treesitter.start()
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"
