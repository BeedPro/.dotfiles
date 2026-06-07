vim.g.mapleader = " "

require("vim._core.ui2").enable {}

-- Plugins.Undotree
vim.cmd.packadd "nvim.undotree"

-- Plugins.Difftool
vim.cmd.packadd "nvim.difftool"

-- Plugins.Modus
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

-- Plugins.FzfLua
vim.pack.add {
  "https://github.com/ibhagwan/fzf-lua",
}

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

vim.keymap.set("n", "<leader>fa", "<cmd>FzfLua files<CR>", { desc = "Find all files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Find recent files in current directory" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files hidden=false<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "Find in project" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "Find help tags" })
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "Find keymaps" })
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "Find marks" })
vim.keymap.set("n", "<leader>fz", "<cmd>FzfLua blines<CR>", { desc = "Search current buffer" })

-- Plugins.Mini
vim.pack.add {
  "https://github.com/nvim-mini/mini.nvim",
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

-- Plugins.Marko
vim.pack.add {
  "https://github.com/mohseenrm/marko.nvim",
}

-- Plugins.NvimLint
vim.pack.add {
  "https://github.com/mfussenegger/nvim-lint",
}

require("lint").linters_by_ft = {
  python = { "ruff" },
  htmldjango = { "djlint" },
  c = { "cpplint" },
  cpp = { "cpplint" },
  haskell = { "hlint" },
  typescript = { "biomejs" },
  typescriptreact = { "biomejs" },
  javascript = { "biomejs" },
  javascriptreact = { "biomejs" },
  json = { "biomejs" },
  html = { "biomejs" },
  css = { "biomejs" },
  svelte = { "biomejs" },
  gdscript = { "gdlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})

-- Plugins.Treesitter
vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
}

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

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterFileTypeStart", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_user_command("TSInstallAll", function()
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
end, {
  desc = "Install predefined Treesitter parsers",
})

-- Plugins.Lazydev
vim.pack.add {
  "https://github.com/folke/lazydev.nvim",
}

require("lazydev").setup {
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
}

-- Plugins.Lsp
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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttachMappings", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "grr", function()
      require("fzf-lua").lsp_references()
    end, { buffer = args.buf, desc = "LSP: find references" })
    vim.keymap.set("n", "gri", function()
      require("fzf-lua").lsp_implementations()
    end, { buffer = args.buf, desc = "LSP: find implementations" })
    vim.keymap.set("n", "grt", function()
      require("fzf-lua").lsp_typedefs()
    end, { buffer = args.buf, desc = "LSP: type definitions" })
    vim.keymap.set("n", "gO", function()
      require("fzf-lua").lsp_document_symbols()
    end, { buffer = args.buf, desc = "LSP: document symbols" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "Go to declaration" })
    vim.keymap.set("n", "gd", function()
      require("fzf-lua").lsp_definitions()
    end, { buffer = args.buf, desc = "Go to definition" })
  end,
})

vim.keymap.set("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Show diagnostics in location list" })
vim.keymap.set("n", "<leader>da", vim.diagnostic.setqflist, { desc = "Show all diagnostics in quickfix" })

-- Plugins.Mason
vim.pack.add {
  "https://github.com/mason-org/mason.nvim",
}

require("mason").setup {
  PATH = "skip",
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
  ui = {
    backdrop = 100,
    icons = {
      package_pending = "[.] ",
      package_installed = "[+] ",
      package_uninstalled = "[ ] ",
    },
  },
  max_concurrent_installers = 10,
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
  require("mason-registry").refresh(function()
    for _, name in ipairs {
      "ty",
      "clangd",
      "haskell-language-server",
      "lua-language-server",
      "biome",
      "typescript-language-server",
      "tailwindcss-language-server",
      "svelte-language-server",
      "debugpy",
      "codelldb",
      "haskell-debug-adapter",
      "js-debug-adapter",
      "firefox-debug-adapter",
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

-- Plugins.Conform
vim.pack.add {
  "https://github.com/stevearc/conform.nvim",
}

require("conform").setup {
  formatters_by_ft = {
    python = { "ruff_format", "ruff_organize_imports" },
    djangohtml = { "djlint" },
    htmldjango = { "djlint" },
    tex = { "tex-fmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    haskell = { "fourmolu" },
    typst = { "prettypst" },
    prolog = { "prolog" },
    lua = { "stylua" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    json = { "biome" },
    html = { "biome" },
    css = { "biome" },
    svelte = { "biome" },
    gdscript = { "gdformat" },
    markdown = { "prettierd" },
    ["_"] = { "trim_whitespace" },
  },
  format_on_save = {
    lsp_format = "never",
    formatters = { "trim_whitespace" },
  },
}

vim.keymap.set({ "n", "x" }, "<leader>cf", function()
  require("conform").format { lsp_fallback = true, async = true }
end, { desc = "Format code" })

-- Plugins.Dap
vim.pack.add {
  "https://github.com/mfussenegger/nvim-dap",
}

vim.fn.sign_define("DapStopped", { text = "> ", texthl = "SignColumn", linehl = "debugPC" })

require("dap").adapters.python = function(cb, config)
  local function python_executable(venv)
    if vim.fn.has "win32" == 1 then
      return vim.fs.joinpath(venv, "Scripts", "python.exe")
    end
    return vim.fs.joinpath(venv, "bin", "python")
  end

  if config.request == "attach" then
    cb {
      type = "server",
      host = (config.connect or config).host or "127.0.0.1",
      port = assert((config.connect or config).port, "`connect.port` is required for python attach"),
      options = {
        source_filetype = "python",
      },
    }
    return
  end

  cb {
    type = "executable",
    command = python_executable(vim.fs.joinpath(vim.fn.stdpath "data", "mason", "packages", "debugpy", "venv")),
    args = { "-m", "debugpy.adapter" },
    options = {
      source_filetype = "python",
    },
  }
end

require("dap").adapters.debugpy = require("dap").adapters.python

require("dap").adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fs.joinpath(vim.fn.stdpath "data", "mason", "bin", "codelldb"),
    args = { "--port", "${port}" },
  },
}

require("dap").adapters.haskell = {
  type = "executable",
  command = "haskell-debug-adapter",
  args = { "--hackage-version=0.0.33.0" },
}

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = vim.fs.joinpath(vim.fn.stdpath "data", "mason", "bin", "js-debug-adapter"),
    args = { "${port}" },
  },
}

require("dap").adapters.firefox = {
  type = "executable",
  command = "node",
  args = {
    vim.fs.joinpath(vim.fn.stdpath "data", "mason", "packages", "firefox-debug-adapter", "dist", "adapter.bundle.js"),
  },
}

require("dap").adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

require("dap").configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    console = "integratedTerminal",
    pythonPath = function()
      local function python_executable(venv)
        if vim.fn.has "win32" == 1 then
          return vim.fs.joinpath(venv, "Scripts", "python.exe")
        end
        return vim.fs.joinpath(venv, "bin", "python")
      end

      if os.getenv "VIRTUAL_ENV" then
        return python_executable(os.getenv "VIRTUAL_ENV")
      end
      if os.getenv "CONDA_PREFIX" then
        if vim.fn.has "win32" == 1 then
          return vim.fs.joinpath(os.getenv "CONDA_PREFIX", "python.exe")
        end
        return vim.fs.joinpath(os.getenv "CONDA_PREFIX", "bin", "python")
      end
      for _, folder in ipairs { "venv", ".venv", "env", ".env" } do
        if (vim.uv or vim.loop).fs_stat(vim.fs.joinpath(vim.fn.getcwd(), folder)) then
          return python_executable(vim.fs.joinpath(vim.fn.getcwd(), folder))
        end
      end
      return "python3"
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file (args)",
    program = "${file}",
    args = function()
      if require("dap.utils").splitstr and vim.fn.has "nvim-0.10" == 1 then
        return require("dap.utils").splitstr(vim.fn.input "Arguments: ")
      end
      return vim.split(vim.fn.input "Arguments: ", " +")
    end,
    console = "integratedTerminal",
    pythonPath = function()
      local function python_executable(venv)
        if vim.fn.has "win32" == 1 then
          return vim.fs.joinpath(venv, "Scripts", "python.exe")
        end
        return vim.fs.joinpath(venv, "bin", "python")
      end

      if os.getenv "VIRTUAL_ENV" then
        return python_executable(os.getenv "VIRTUAL_ENV")
      end
      if os.getenv "CONDA_PREFIX" then
        if vim.fn.has "win32" == 1 then
          return vim.fs.joinpath(os.getenv "CONDA_PREFIX", "python.exe")
        end
        return vim.fs.joinpath(os.getenv "CONDA_PREFIX", "bin", "python")
      end
      for _, folder in ipairs { "venv", ".venv", "env", ".env" } do
        if (vim.uv or vim.loop).fs_stat(vim.fs.joinpath(vim.fn.getcwd(), folder)) then
          return python_executable(vim.fs.joinpath(vim.fn.getcwd(), folder))
        end
      end
      return "python3"
    end,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach process",
    connect = function()
      local host = vim.fn.input "Host [127.0.0.1]: "
      return {
        host = host ~= "" and host or "127.0.0.1",
        port = tonumber(vim.fn.input "Port [5678]: ") or 5678,
      }
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Run doctest",
    module = "doctest",
    args = { "${file}" },
    noDebug = true,
    console = "integratedTerminal",
    pythonPath = function()
      local function python_executable(venv)
        if vim.fn.has "win32" == 1 then
          return vim.fs.joinpath(venv, "Scripts", "python.exe")
        end
        return vim.fs.joinpath(venv, "bin", "python")
      end

      if os.getenv "VIRTUAL_ENV" then
        return python_executable(os.getenv "VIRTUAL_ENV")
      end
      if os.getenv "CONDA_PREFIX" then
        if vim.fn.has "win32" == 1 then
          return vim.fs.joinpath(os.getenv "CONDA_PREFIX", "python.exe")
        end
        return vim.fs.joinpath(os.getenv "CONDA_PREFIX", "bin", "python")
      end
      for _, folder in ipairs { "venv", ".venv", "env", ".env" } do
        if (vim.uv or vim.loop).fs_stat(vim.fs.joinpath(vim.fn.getcwd(), folder)) then
          return python_executable(vim.fs.joinpath(vim.fn.getcwd(), folder))
        end
      end
      return "python3"
    end,
  },
}

require("dap").configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. package.config:sub(1, 1), "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    console = "integratedTerminal",
  },
  {
    name = "Launch file (args)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      return vim.split(vim.fn.input "Args: ", " +", { trimempty = true })
    end,
    console = "integratedTerminal",
  },
}

require("dap").configurations.c = require("dap").configurations.cpp

require("dap").configurations.haskell = {
  {
    type = "haskell",
    request = "launch",
    name = "Debug",
    workspace = "${workspaceFolder}",
    startup = "${file}",
    stopOnEntry = true,
    logFile = vim.fs.joinpath(vim.fn.stdpath "data", "haskell-dap.log"),
    logLevel = "WARNING",
    ghciEnv = vim.empty_dict(),
    ghciPrompt = "ghci> ",
    ghciInitialPrompt = "ghci> ",
    ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
  },
}

require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach process",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
  {
    type = "firefox",
    request = "launch",
    name = "Launch browser",
    reAttach = true,
    url = function()
      local host = vim.fn.input "Host [localhost]: "
      local port = vim.fn.input "Port [3000]: "
      return "http://" .. (host ~= "" and host or "localhost") .. ":" .. (port ~= "" and port or "3000")
    end,
    webRoot = "${workspaceFolder}",
    firefoxExecutable = vim.fn.exepath "firefox" ~= "" and vim.fn.exepath "firefox" or "firefox",
  },
}

require("dap").configurations.javascriptreact = require("dap").configurations.javascript
require("dap").configurations.typescript = require("dap").configurations.javascript
require("dap").configurations.typescriptreact = require("dap").configurations.javascript
require("dap").configurations.svelte = require("dap").configurations.javascript

require("dap").configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
  },
}

vim.keymap.set("n", "<Right>", function()
  require("dap").step_into()
end, { desc = "Debug: step into" })
vim.keymap.set("n", "<Down>", function()
  require("dap").step_over()
end, { desc = "Debug: step over" })
vim.keymap.set("n", "<Left>", function()
  require("dap").step_out()
end, { desc = "Debug: step out" })
vim.keymap.set("n", "<Up>", function()
  require("dap").restart_frame()
end, { desc = "Debug: restart frame" })
vim.keymap.set("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug: toggle breakpoint" })
vim.keymap.set("n", "<leader>dr", function()
  require("dap").continue()
end, { desc = "Debug: run or continue" })
vim.keymap.set("n", "<leader>dR", function()
  require("dap").restart()
end, { desc = "Debug: restart session" })
vim.keymap.set("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Debug: run last configuration" })
vim.keymap.set("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "Debug: terminate session" })

-- Plugins.DapView
vim.pack.add {
  "https://github.com/igorlfs/nvim-dap-view",
}

require("dap-view").setup {
  winbar = {
    sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
    default_section = "scopes",
    controls = { enabled = true },
  },
  windows = {
    terminal = {
      size = 0.40,
      position = "right",
      hide = { "delve" },
    },
  },
  auto_toggle = true,
}

vim.keymap.set("n", "<leader>dw", function()
  require("dap-view").add_expr()
end, { desc = "Debug: add watch expression" })
vim.keymap.set("n", "<leader>dk", function()
  require("dap-view").hover()
end, { desc = "Debug: hover value" })
vim.keymap.set("n", "<leader>dv", function()
  require("dap-view").virtual_text_toggle()
end, { desc = "Debug: toggle virtual text" })

-- Plugins.Neogit
vim.pack.add {
  "https://github.com/NeogitOrg/neogit",
}

require("neogit").setup {
  disable_hint = true,
}

vim.keymap.set("n", "<leader>gg", function()
  require("neogit").open()
end, { desc = "Open Neogit" })

-- Plugins.Gitsigns
vim.pack.add {
  "https://github.com/lewis6991/gitsigns.nvim",
}

require("gitsigns").setup {
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "^" },
    changedelete = { text = "!" },
    untracked = { text = "?" },
  },
  signs_staged = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "^" },
    changedelete = { text = "!" },
    untracked = { text = "?" },
  },
  on_attach = function(bufnr)
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal { "]c", bang = true }
      else
        require("gitsigns").nav_hunk "next"
      end
    end, { buffer = bufnr, desc = "Git: next hunk" })
    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal { "[c", bang = true }
      else
        require("gitsigns").nav_hunk "prev"
      end
    end, { buffer = bufnr, desc = "Git: previous hunk" })
    vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk, { buffer = bufnr, desc = "Git: stage hunk" })
    vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk, { buffer = bufnr, desc = "Git: reset hunk" })
    vim.keymap.set("v", "<leader>hs", function()
      require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { buffer = bufnr, desc = "Git: stage selected hunk" })
    vim.keymap.set("v", "<leader>hr", function()
      require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { buffer = bufnr, desc = "Git: reset selected hunk" })
    vim.keymap.set("n", "<leader>hS", require("gitsigns").stage_buffer, { buffer = bufnr, desc = "Git: stage buffer" })
    vim.keymap.set("n", "<leader>hR", require("gitsigns").reset_buffer, { buffer = bufnr, desc = "Git: reset buffer" })
    vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { buffer = bufnr, desc = "Git: preview hunk" })
    vim.keymap.set("n", "<leader>hi", require("gitsigns").preview_hunk_inline, { buffer = bufnr, desc = "Git: preview inline hunk" })
    vim.keymap.set("n", "<leader>hb", function()
      require("gitsigns").blame_line { full = true }
    end, { buffer = bufnr, desc = "Git: blame line" })
    vim.keymap.set("n", "<leader>hd", require("gitsigns").diffthis, { buffer = bufnr, desc = "Git: diff against index" })
    vim.keymap.set("n", "<leader>hD", function()
      require("gitsigns").diffthis "~"
    end, { buffer = bufnr, desc = "Git: diff against previous commit" })
    vim.keymap.set("n", "<leader>hQ", function()
      require("gitsigns").setqflist "all"
    end, { buffer = bufnr, desc = "Git: hunks to quickfix (all)" })
    vim.keymap.set("n", "<leader>hq", require("gitsigns").setqflist, { buffer = bufnr, desc = "Git: hunks to quickfix" })
    vim.keymap.set({ "o", "x" }, "ih", require("gitsigns").select_hunk, { buffer = bufnr, desc = "Select inside hunk" })
  end,
}

-- Plugins.Diffview
vim.pack.add {
  "https://github.com/sindrets/diffview.nvim",
}

require("diffview").setup {
  use_icons = false,
}

-- Plugins.Neogen
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

-- Plugins.Kanso
vim.pack.add {
  "https://github.com/webhooked/kanso.nvim",
}

require("kanso").setup {
  italics = false,
  undercurl = false,
  background = {
    dark = "zen",
    light = "pearl",
  },
  overrides = function(colors)
    return {
      ["@markup.underline"] = { underline = false, undercurl = false },
      ["@string.special.url"] = { underline = false, undercurl = false },
      Underlined = { underline = false, undercurl = false },
      SpellBad = { underline = false, undercurl = true },
      SpellCap = { underline = false, undercurl = true },
      SpellLocal = { underline = false, undercurl = true },
      SpellRare = { underline = false, undercurl = true },
      LspReferenceWrite = { underline = false, undercurl = false },
      IndentBlanklineContextStart = { underline = false, undercurl = false },
      ["@ibl.scope.underline.1"] = { underline = false, undercurl = false },
      MiniCompletionActiveParameter = { underline = false, undercurl = false },
      MiniCursorword = { underline = false, undercurl = false },
      MiniCursorwordCurrent = { underline = false, undercurl = false },
      NeotestFocused = { underline = false, undercurl = false },
      WinSeparator = { fg = colors.palette.gray3 },
    }
  end,
}

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("DapColorScheme", { clear = true }),
  callback = function()
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "debugPC", {
        bg = require("kanso.colors").setup().theme.ui.bg_dim,
      })
    end)
  end,
})

-- Plugins.Oil
vim.pack.add {
  "https://github.com/stevearc/oil.nvim",
}

require("oil").setup {
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
  },
  columns = {},
}

vim.keymap.set("n", "<leader>.", function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open()
  end
end, { desc = "Toggle file explorer" })

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("OilOpenOnStart", { clear = true }),
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 then
      vim.schedule(function()
        vim.cmd.cd(data.file)
        vim.cmd("Oil " .. vim.fn.fnameescape(data.file))
      end)
      return
    end
    if data.file == "" and vim.bo[data.buf].buftype == "" then
      return
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("OilMappings", { clear = true }),
  pattern = "oil",
  callback = function(args)
    vim.b[args.buf].oil_detail = vim.b[args.buf].oil_detail or false
    vim.keymap.set("n", "gd", function()
      vim.b[args.buf].oil_detail = not vim.b[args.buf].oil_detail
      if vim.b[args.buf].oil_detail then
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

-- Plugins.Orgmode
vim.pack.add {
  "https://github.com/nvim-orgmode/orgmode",
}

local function face_from_hl(hl, opts)
  opts = opts or {}
  local ok, def = pcall(vim.api.nvim_get_hl, 0, { name = hl, link = true })
  if not ok or not def or not def.fg then
    return opts.fallback or ":weight bold"
  end
  local parts = { string.format(":foreground #%06x", def.fg) }
  if opts.bold then
    table.insert(parts, ":weight bold")
  end
  if opts.italic then
    table.insert(parts, ":slant italic")
  end
  return table.concat(parts, " ")
end

require("orgmode").setup {
  org_agenda_files = {
    vim.fs.normalize(vim.fn.expand "~/Compendium/Journal") .. package.config:sub(1, 1) .. "capture.org",
    vim.fs.normalize(vim.fn.expand "~/Compendium/Journal") .. package.config:sub(1, 1) .. "wishlist.org",
  },
  org_default_notes_file = vim.fs.normalize(vim.fn.expand "~/Compendium/Journal") .. package.config:sub(1, 1) .. "capture.org",
  org_todo_keywords = { "TODO(t)", "NEXT(n)", "WAITING(w)", "|", "DONE(d)", "CANCELLED(c)" },
  org_todo_keyword_faces = {
    TODO = face_from_hl("DiagnosticError", { bold = true }),
    NEXT = face_from_hl("DiagnosticInfo", { bold = true }),
    WAITING = face_from_hl("DiagnosticWarn", { bold = true }),
    DONE = face_from_hl("DiagnosticOk", { bold = true, fallback = face_from_hl("DiffAdd", { bold = true }) }),
    CANCELLED = face_from_hl("Comment", { italic = true }),
  },
  org_ellipsis = "...",
  org_startup_folded = "content",
  org_startup_indented = true,
  org_hide_leading_stars = true,
  org_adapt_indentation = false,
  org_log_done = "time",
  org_log_into_drawer = "LOGBOOK",
  org_edit_src_content_indentation = 0,
  win_split_mode = "tabnew",
  mappings = {
    capture = {
      org_capture_refile = "<C-w>",
      org_capture_kill = "<C-k>",
    },
  },
  org_capture_templates = {
    t = {
      description = "Task",
      template = "** TODO %<%H%M%S> - %?",
      target = vim.fs.normalize(vim.fn.expand "~/Compendium/Journal") .. package.config:sub(1, 1) .. "capture.org",
      datetree = {
        reversed = true,
        tree_type = "custom",
        tree = {
          {
            format = "%Y%m%d",
            pattern = "^(%d%d%d%d)(%d%d)(%d%d)$",
            order = { 1, 2, 3 },
          },
        },
      },
      properties = { empty_lines = { before = 0, after = 0 } },
    },
    n = {
      description = "Note",
      template = "** %<%H%M%S> - %?",
      target = vim.fs.normalize(vim.fn.expand "~/Compendium/Journal") .. package.config:sub(1, 1) .. "capture.org",
      datetree = {
        reversed = true,
        tree_type = "custom",
        tree = {
          {
            format = "%Y%m%d",
            pattern = "^(%d%d%d%d)(%d%d)(%d%d)$",
            order = { 1, 2, 3 },
          },
        },
      },
      properties = { empty_lines = { before = 0, after = 0 } },
    },
  },
}

vim.lsp.enable "org"

-- Plugins.Blink
vim.pack.add {
  "https://github.com/saghen/blink.cmp",
  "https://github.com/saghen/blink.lib",
  "https://github.com/ribru17/blink-cmp-spell",
}

require("blink.cmp").setup {
  snippets = { preset = "luasnip" },
  cmdline = {
    keymap = {
      ["<Tab>"] = { "show", "select_next" },
    },
    completion = {
      menu = {
        auto_show = false,
      },
      list = {
        selection = {
          preselect = false,
        },
      },
    },
  },
  appearance = {
    nerd_font_variant = "mono",
    kind_icons = {
      Text = "[T]",
      Method = "[M]",
      Function = "[F]",
      Constructor = "[C]",
      Field = "[Fd]",
      Variable = "[V]",
      Property = "[P]",
      Class = "[Cl]",
      Interface = "[I]",
      Struct = "[St]",
      Module = "[Mo]",
      Unit = "[U]",
      Value = "[Val]",
      Enum = "[E]",
      EnumMember = "[Em]",
      Keyword = "[K]",
      Constant = "[Co]",
      Snippet = "[S]",
      Color = "[Col]",
      File = "[Fi]",
      Reference = "[R]",
      Folder = "[Dir]",
      Event = "[Ev]",
      Operator = "[Op]",
      TypeParameter = "[Tp]",
    },
  },
  fuzzy = { implementation = "prefer_rust" },
  sources = {
    default = { "lsp", "snippets", "buffer", "path" },
    providers = {
      spell = {
        name = "Spell",
        module = "blink-cmp-spell",
        opts = {
          max_entries = 20,
          keep_all_entries = true,
        },
      },
    },
  },
  keymap = {
    preset = "none",
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "accept", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-j>"] = { "snippet_forward", "fallback" },
    ["<C-k>"] = { "snippet_backward", "fallback" },
  },
  completion = {
    ghost_text = { enabled = false },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "single" },
    },
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      auto_show = false,
    },
  },
  signature = { enabled = false },
}

vim.keymap.set("i", "<C-x><C-o>", function()
  require("blink.cmp").show()
end, { desc = "Show completion menu" })
vim.keymap.set("i", "<C-x><C-s>", function()
  require("blink.cmp").show { providers = { "spell" } }
end, { desc = "Show spelling completions" })

-- Plugins.LuaSnip
vim.pack.add {
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",
}

require("luasnip").config.set_config { history = true, updateevents = "TextChanged,TextChangedI" }

require("luasnip.loaders.from_vscode").lazy_load {
  exclude = {},
  fs_event_providers = { autocmd = true, libuv = true },
}

require("luasnip.loaders.from_vscode").lazy_load {
  paths = { vim.fs.joinpath(vim.fn.stdpath "config", "vscode") },
  fs_event_providers = { autocmd = true, libuv = true },
}

require("luasnip.loaders.from_snipmate").lazy_load {
  paths = { vim.fs.joinpath(vim.fn.stdpath "config", "snipmate") },
  fs_event_providers = { autocmd = true, libuv = true },
}

require("luasnip.loaders.from_lua").lazy_load {
  paths = { vim.fs.joinpath(vim.fn.stdpath "config", "luasnips") },
  fs_event_providers = { autocmd = true, libuv = true },
}

vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("LuasnipCleanup", { clear = true }),
  callback = function()
    if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})

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
-- Mappings
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
