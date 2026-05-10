vim.g.mapleader = " "

-- Plugins
vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/mohseenrm/marko.nvim",
}

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

---- Plugins.oil
require("oil").setup {
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
  },
  columns = {},
}

---- Plugins.fzf-lua
require("fzf-lua").setup {
  { "telescope", "hide" },
  defaults = {
    file_icons = false,
    git_icons = false,
    color_icons = false,
  },
  fzf_colors = true,
  fzf_opts = {
    ["--layout"] = "reverse",
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  winopts = function()
    local small = vim.o.columns < 120 or vim.o.lines < 35

    return {
      height = 0.8,
      width = 0.9,
      row = 0.5,
      col = 0.5,
      border = "single",
      backdrop = 100,
      preview = {
        hidden = small,
        layout = "flex",
        flip_columns = 120,
        vertical = "down:45%",
        horizontal = "right:55%",
        border = "single",
      },
    }
  end,
  files = {
    cwd_prompt = false,
  },
  oldfiles = {
    cwd_only = true,
  },
  keymaps = {
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:60%",
      },
    },
  },
}

---- Plugins.mini
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

vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

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

---- Autocmds.oil
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("OilOpenOnStart", { clear = true }),
  callback = function(data)
    local is_dir = vim.fn.isdirectory(data.file) == 1
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    if not is_dir and not no_name then
      return
    end

    if is_dir then
      vim.schedule(function()
        vim.cmd.cd(data.file)
        vim.cmd("Oil " .. vim.fn.fnameescape(data.file))
      end)
    end
  end,
})

-- Mappings
vim.keymap.set("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "[D]iagnostic [S]how (loclist)" })
vim.keymap.set("n", "<leader>da", vim.diagnostic.setqflist, { desc = "[D]iagnostic [A]ll (quickfix)" })

---- Mappings.oil
local oil_detail = false

vim.keymap.set("n", "<leader>.", function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open()
  end
end, { desc = "[O]il Toggle" })

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("OilMappings", { clear = true }),
  pattern = "oil",
  callback = function(args)
    vim.keymap.set("n", "gd", function()
      oil_detail = not oil_detail
      if oil_detail then
        require("oil").set_columns { "permissions", "size", "mtime" }
      else
        require("oil").set_columns {}
      end
    end, { buffer = args.buf, desc = "Toggle file detail view" })

    vim.keymap.set("n", "<leader>ff", function()
      require("fzf-lua").files {
        cwd = require("oil").get_current_dir(),
      }
    end, { buffer = args.buf, desc = "Find files in the current directory" })
  end,
})

---- Mappings.fzf-lua
vim.keymap.set("n", "<leader>fa", "<cmd>FzfLua files<CR>", { desc = "[F]ind [A]ll Files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "[F]ind [R]ecent Files (cwd)" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files hidden=false<CR>", { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "[F]ind [W]ords" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "[F]ind [M]arks" })
vim.keymap.set("n", "<leader>fz", "<cmd>FzfLua blines<CR>", { desc = "[F]ind Fu[Z]zy Buffer" })
