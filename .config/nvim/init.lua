vim.g.mapleader = " "

vim.cmd.packadd "nvim.undotree"
vim.cmd.packadd "nvim.difftool"
require("vim._core.ui2").enable {}

-- Plugins
vim.pack.add {
  "https://github.com/miikanissi/modus-themes.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/mohseenrm/marko.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/folke/lazydev.nvim",
}

-- Plugins.Treesitter
require("nvim-treesitter").install {
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

-- Options
vim.o.spellfile = vim.fs.joinpath(vim.fn.stdpath "config", "spell", "en.utf-8.add")

vim.o.list = true
vim.o.background = "dark"
vim.o.winborder = "single"
vim.o.laststatus = 3
vim.o.splitkeep = "screen"

vim.o.clipboard = ""
vim.o.cursorline = true
vim.o.cursorlineopt = "both"
vim.o.completeopt = "menu,popup,noselect"

vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.mouse = "a"

vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2
vim.o.ruler = false

vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeoutlen = 400
vim.o.undofile = true
vim.o.undodir = vim.fs.joinpath(vim.fn.stdpath "data", "undodir")

vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldtext = "v:folddashes.substitute(getline(v:foldstart),'/\\*\\|\\*/\\|{{{\\d\\=','','g')"

vim.o.updatetime = 250

vim.opt.fillchars = { eob = " " }
vim.opt.guicursor = ""
vim.opt.shortmess:append "sI"
vim.opt.wrap = false

vim.opt.whichwrap:append "<>[]hl"

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.netrw_banner = 0

-- Autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.hl.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("DotenvFt", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterFileTypeStart", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("AutoResizeSplits", { clear = true }),
  command = "wincmd =",
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("ToggleListchars", { clear = true }),
  callback = function()
    vim.opt_local.listchars = { tab = "> ", nbsp = "+" }
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("ToggleListchars", { clear = false }),
  callback = function()
    vim.opt_local.listchars = { tab = "> ", nbsp = "+", trail = "-" }
  end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("BigFile", { clear = true }),
  callback = function(args)
    if vim.api.nvim_buf_get_name(args.buf) == "" then
      return
    end
    if vim.fn.getfsize(vim.api.nvim_buf_get_name(args.buf)) <= 1024 * 1024 * 1.5 then
      return
    end
    vim.b[args.buf].bigfile = true
    vim.notify(
      ("Big file detected: %.2f MiB"):format(vim.fn.getfsize(vim.api.nvim_buf_get_name(args.buf)) / 1024 / 1024),
      vim.log.levels.WARN,
      { title = "BigFile" }
    )
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.swapfile = false
    vim.opt_local.undofile = false
    vim.opt_local.spell = false
    vim.opt_local.list = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("BigFile", { clear = false }),
  callback = function(args)
    if not vim.b[args.buf].bigfile then
      return
    end
    pcall(vim.treesitter.stop, args.buf)
    pcall(vim.api.nvim_buf_call, args.buf, function()
      vim.cmd.syntax "off"
    end)
  end,
})


-- Commands
vim.api.nvim_create_user_command("MasonInstallAll", function()
  require("mason-registry").refresh(function()
    for _, name in ipairs {
      -- LSP
      "ty",
      "clangd",
      "haskell-language-server",
      "lua-language-server",
      "biome",
      "typescript-language-server",
      "tailwindcss-language-server",
      "svelte-language-server",

      -- DAP
      "debugpy",
      "codelldb",
      "haskell-debug-adapter",
      "js-debug-adapter",
      "firefox-debug-adapter",

      -- Linters / Formatters
      "ruff",
      "djlint",
      "cpplint",
      "clang-format",
      "fourmolu",
      "hlint",
      "stylua",
      "prettierd",
      "gdtoolkit",
    } do
      if pcall(require("mason-registry").get_package, name)
        and not select(2, pcall(require("mason-registry").get_package, name)):is_installed()
      then
        select(2, pcall(require("mason-registry").get_package, name)):install()
      end
    end
  end)
  vim.cmd "Mason"
end, {
  desc = "Install predefined Mason packages",
})

-- Mappings
vim.keymap.set("n", "<leader>fa", "<cmd>FzfLua files<CR>", { desc = "Find all files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Find recent files in current directory" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files hidden=false<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "Find in project" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "Find help tags" })
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "Find keymaps" })
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "Find marks" })
vim.keymap.set("n", "<leader>fz", "<cmd>FzfLua blines<CR>", { desc = "Search current buffer" })

vim.keymap.set("n", "<leader>ta", function()
  if vim.wo.arabic then
    if vim.b._arabic_toggle_manages_spell == nil then
      vim.b._arabic_toggle_manages_spell = vim.wo.spell
    end
    if vim.b._arabic_toggle_manages_spell then
      vim.cmd "set spell"
    end
    vim.cmd "set noarab"
    return
  end
  if vim.b._arabic_toggle_manages_spell == nil then
    vim.b._arabic_toggle_manages_spell = vim.wo.spell
  end
  if vim.b._arabic_toggle_manages_spell then
    vim.cmd "set nospell"
  end
  vim.cmd "set arab"
end, { desc = "Toggle Arabic" })

vim.keymap.set("i", "<C-^>", function()
  if vim.wo.arabic then
    if vim.b._arabic_toggle_manages_spell == nil then
      vim.b._arabic_toggle_manages_spell = vim.wo.spell
    end
    if vim.b._arabic_toggle_manages_spell then
      vim.cmd "set spell"
    end
    return vim.api.nvim_replace_termcodes("<C-o>:set noarab<CR>", true, false, true)
  end
  if vim.b._arabic_toggle_manages_spell == nil then
    vim.b._arabic_toggle_manages_spell = vim.wo.spell
  end
  if vim.b._arabic_toggle_manages_spell then
    vim.cmd "set nospell"
  end
  return vim.api.nvim_replace_termcodes("<C-o>:set arab<CR>", true, false, true)
end, { expr = true, desc = "Toggle Arabic" })

vim.cmd.colorscheme "modus"
