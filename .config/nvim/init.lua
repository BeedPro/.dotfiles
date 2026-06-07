vim.g.mapleader = " "

require("vim._core.ui2").enable {}

vim.cmd.packadd "nvim.undotree"
vim.cmd.packadd "nvim.difftool"
require("modus_config")
require("fzf_lua_config")
require("mini_config")
require("marko_config")
require("nvim_lint_config")
require("treesitter_config")
require("lazydev_config")
require("mason_config")
require("conform_config")
require("dap_config")
require("dap_view_config")
require("neogit_config")
require("gitsigns_config")
require("diffview_config")
require("neogen_config")
require("kanso_config")
require("oil_config")
require("orgmode_config")
require("blink_config")
require("luasnip_config")

-- LSP
vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          preselectSupport = true,
          commitCharactersSupport = true,
          resolveSupport = {
            properties = {
              "documentation",
              "detail",
              "additionalTextEdits",
            },
          },
        },
      },
    },
  },
})

vim.diagnostic.config {
  underline = false,
}

vim.lsp.document_color.enable(false)

vim.lsp.enable {
  "ty",
  "clangd",
  "hls",
  "tinymist",
  "prolog_ls",
  "lua_ls",
  "biome",
  "ts_ls",
  "tailwindcss",
  "svelte",
  "gdscript",
  "texlab",
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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("BuiltinLspMappings", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "Go to declaration" })
  end,
})

-- Mappings
vim.keymap.set("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Show diagnostics in location list" })
vim.keymap.set("n", "<leader>da", vim.diagnostic.setqflist, { desc = "Show all diagnostics in quickfix" })

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
