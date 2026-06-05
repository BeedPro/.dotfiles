vim.g.mapleader = " "

-- Plugins
vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/mohseenrm/marko.nvim",
  "https://github.com/miikanissi/modus-themes.nvim",
}

vim.cmd.packadd "nvim.undotree"
require("vim._core.ui2").enable {}

---- Plugins.theme
vim.cmd.colorscheme "modus"

---- Plugins.nvim-lint
require("lint").linters_by_ft = {
  python = { "ruff" },
  c = { "cpplint" },
  cpp = { "cpplint" },
}

---- Plugins.lazydev
require("lazydev").setup {
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
}

---- Plugins.mini
local show_dotfiles = true

local filter_show = function()
  return true
end

local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, ".")
end

local files_in = function(cwd, hidden)
  local command = { "rg", "--files" }

  if hidden then
    vim.list_extend(command, { "--hidden", "--glob", "!**/.git/*" })
  end

  require("mini.pick").builtin.cli(
    { command = command },
    {
      source = { cwd = cwd },
    }
  )
end

local explorer_path = function()
  local entry = require("mini.files").get_fs_entry()

  if not entry then
    return vim.uv.cwd()
  end

  return entry.fs_type == "directory" and entry.path or vim.fs.dirname(entry.path)
end

require("mini.files").setup {
  content = {
    filter = filter_show,
    prefix = function()
    end,
  },
  mappings = {
    close = "q",
    go_in = "l",
    go_in_plus = "L",
    go_out = "h",
    go_out_plus = "H",
    mark_goto = "'",
    mark_set = "m",
    reset = "<BS>",
    reveal_cwd = "@",
    show_help = "g?",
    synchronize = "=",
    trim_left = "<",
    trim_right = ">",
  },
  options = {
    use_as_default_explorer = true,
  },
  windows = {
    preview = false,
    width_focus = 35,
    width_nofocus = 20,
    width_preview = 55,
  },
}

require("mini.pick").setup {
  source = {
    show = require("mini.pick").default_show,
  },
}

require("mini.extra").setup()

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

---- Plugins.marko
require("marko").setup {}

-- LSP
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

lsp_capabilities.textDocument.completion.completionItem = {
  preselectSupport = true,
  commitCharactersSupport = true,
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

vim.diagnostic.config {
  underline = false,
}

vim.lsp.document_color.enable(false)

vim.lsp.config("*", {
  capabilities = lsp_capabilities,
})

vim.lsp.enable {
  "ty",
  "clangd",
  "lua_ls",
}

-- Options
vim.o.spellfile = vim.fs.joinpath(vim.fn.stdpath "config", "spell", "en.utf-8.add")

vim.o.background = "dark"
vim.o.winborder = "single"
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.splitkeep = "screen"

vim.o.clipboard = ""
vim.o.cursorline = true
vim.o.cursorlineopt = "both"
vim.o.completeopt = "menu,popup,noselect"
vim.opt.wildoptions = "pum"
vim.opt.wildmode = "noselect:full,full"

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

vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("BigFile", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    if file == "" then
      return
    end

    local ok, stat = pcall(vim.uv.fs_stat, file)
    if not ok or not stat or stat.size <= 1024 * 1024 * 1.5 then
      return
    end

    vim.b[args.buf].bigfile = true

    vim.notify(
      ("Big file detected: %.2f MiB"):format(stat.size / 1024 / 1024),
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

-- Mappings
vim.keymap.set("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "[D]iagnostic [S]how (loclist)" })
vim.keymap.set("n", "<leader>da", vim.diagnostic.setqflist, { desc = "[D]iagnostic [A]ll (quickfix)" })

vim.keymap.set("n", "<leader>.", function()
  if not require("mini.files").close() then
    require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
  end
end, { desc = "Toggle file explorer" })

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("MiniFilesMappings", { clear = true }),
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id

    vim.keymap.set("n", "<leader>ff", function()
      files_in(explorer_path(), false)
    end, { buffer = buf_id, desc = "Find files in the current directory" })

    vim.keymap.set("n", "gd", function()
      show_dotfiles = not show_dotfiles
      require("mini.files").refresh {
        content = {
          filter = show_dotfiles and filter_show or filter_hide,
        },
      }
    end, { buffer = buf_id, desc = "Toggle hidden files" })
  end,
})

vim.keymap.set("n", "<leader>fa", function()
  files_in(vim.uv.cwd(), true)
end, { desc = "[F]ind [A]ll Files" })
vim.keymap.set("n", "<leader>fr", function()
  require("mini.extra").pickers.oldfiles { current_dir = true }
end, { desc = "[F]ind [R]ecent Files (cwd)" })
vim.keymap.set("n", "<leader>ff", function()
  require("mini.pick").builtin.files()
end, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fw", function()
  require("mini.pick").builtin.grep_live()
end, { desc = "[F]ind [W]ords" })
vim.keymap.set("n", "<leader>fb", function()
  require("mini.pick").builtin.buffers()
end, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fh", function()
  require("mini.pick").builtin.help()
end, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", function()
  require("mini.extra").pickers.keymaps()
end, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fm", function()
  require("mini.extra").pickers.marks()
end, { desc = "[F]ind [M]arks" })
vim.keymap.set("n", "<leader>fz", function()
  require("mini.extra").pickers.buf_lines { scope = "current" }
end, { desc = "[F]ind Fu[Z]zy Buffer" })
