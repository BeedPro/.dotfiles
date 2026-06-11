vim.pack.add {
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/danymat/neogen",
  "https://github.com/rafamadriz/friendly-snippets",
}

local function termcodes(keys)
  return vim.api.nvim_replace_termcodes(keys, true, false, true)
end

local function small_screen()
  return vim.o.columns < 120 or vim.o.lines < 35
end

local function pick_window_config()
  local height = math.floor(vim.o.lines * 0.8)
  local width = math.floor(vim.o.columns * 0.9)
  return {
    anchor = "NW",
    height = height,
    width = width,
    row = math.floor((vim.o.lines - height) * 0.5),
    col = math.floor((vim.o.columns - width) * 0.5),
    border = "single",
  }
end

local function pick_show_no_icons(buf_id, items, query)
  return require("mini.pick").default_show(buf_id, items, query, { show_icons = false })
end

local function with_cwd(cwd)
  return { source = { cwd = cwd } }
end

local function completion_scroll(direction, fallback)
  return function()
    if require("mini.completion").scroll(direction) then
      return ""
    end
    return termcodes(fallback)
  end
end

local function snippet_jump(direction)
  return function()
    local session = _G.MiniSnippets and MiniSnippets.session.get() or nil
    if not session then
      return ""
    end
    MiniSnippets.session.jump(direction)
    return ""
  end
end

local function snippet_expand_or_jump()
  local has_session = _G.MiniSnippets and MiniSnippets.session.get() ~= nil
  if has_session then
    MiniSnippets.session.jump "next"
    return ""
  end

  local matches = MiniSnippets.expand { insert = false }
  if matches and #matches > 0 then
    vim.schedule(function()
      MiniSnippets.expand()
    end)
  end
  return ""
end

local function all_snippets(context)
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(context.buf_id), ":t:r")
  filename = filename ~= "" and filename or "Title"

  return {
    {
      prefix = "checkhealth_snipmate",
      body = "Yes, snipmate works!",
      desc = "Check snipmate snippets",
    },
    {
      prefix = "helloworld",
      body = "Hello, world!\\n",
    },
    {
      prefix = "checkhealth_luasnips",
      body = "Yes, luasnips works!",
    },
    {
      prefix = "dtid",
      body = os.date "%Y%m%d%H%M%S",
    },
    {
      prefix = "tid",
      body = os.date "%H%M%S",
    },
    {
      prefix = "did",
      body = os.date "%Y%m%d",
    },
    {
      prefix = "link",
      body = "[[$1][$2]]",
      desc = "Org link",
    },
    {
      prefix = "hdoc",
      body = "-- | ${1:[TODO: description]}",
    },
    {
      prefix = "hdocm",
      body = { "{-|", "  ${1:[TODO: description]}", "-}" },
    },
    {
      prefix = "hmod",
      body = {
        "{-|",
        "Module      : ${1:[TODO: module.name]}",
        "Description : ${2:[TODO: short description]}",
        "Copyright   : ${3:[TODO: copyright]}",
        "License     : ${4:[TODO: license]}",
        "Maintainer  : ${5:[TODO: maintainer@email.com]}",
        "Stability   : ${6:[TODO: stability]}",
        "Portability : ${7:[TODO: portability]}",
        "",
        "${8:[TODO: longer module description]}",
        "-}",
      },
    },
    {
      prefix = "hsec",
      body = "-- * ${1:[TODO: section heading]}",
    },
    {
      prefix = "hsubsec",
      body = "-- ** ${1:[TODO: subsection heading]}",
    },
    {
      prefix = "hchunk",
      body = { "-- $${1:[TODO: chunkName]}", "-- ${2:[TODO: chunk documentation]}" },
    },
    {
      prefix = "hsince",
      body = "-- @since ${1:[TODO: version]}",
    },
    {
      prefix = "harg",
      body = "${1:[TODO: name]} :: ${2:[TODO: Type]}  -- ^ ${3:[TODO: description]}",
    },
    {
      prefix = "hex",
      body = { "-- >>> ${1:[TODO: expression]}", "-- ${2:[TODO: result]}" },
    },
    {
      prefix = "hprop",
      body = "-- prop> ${1:[TODO: property]}",
    },
    {
      prefix = "hcode",
      body = { "-- @", "-- ${1:[TODO: code]}", "-- @" },
    },
    {
      prefix = "hbird",
      body = "-- > ${1:[TODO: code]}",
    },
    {
      prefix = "hlist",
      body = { "-- ", "-- * ${1:[TODO: first item]}", "-- ", "-- * ${2:[TODO: second item]}" },
    },
    {
      prefix = "henum",
      body = { "-- ", "-- (1) ${1:[TODO: first item]}", "-- ", "-- 2. ${2:[TODO: second item]}" },
    },
    {
      prefix = "hdef",
      body = "-- [@${1:[TODO: term]}@]: ${2:[TODO: definition]}",
    },
    {
      prefix = "hlink",
      body = "[${1:[TODO: link text]}](${2:[TODO: URL]})",
    },
    {
      prefix = "himg",
      body = "![${1:[TODO: image description]}](${2:[TODO: path/to/image.png]})",
    },
    {
      prefix = "zettel",
      body = {
        '#import ".utility/style.typ": style',
        "#show: style",
        "",
        '#let title = "${1:' .. filename .. '}"',
        "#let id = " .. filename,
        "",
        "#id${2::ghost:}",
        "",
        "= #title",
        "",
        "$0",
        "",
        "= Links",
        "",
        '#bibliography(".utility/sources.yaml")',
      },
    },
  }
end

require("mini.pick").setup {
  source = {
    show = pick_show_no_icons,
  },
  window = {
    config = pick_window_config,
  },
  mappings = {
    move_down = "<C-n>",
    move_up = "<C-p>",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
    toggle_preview = "<Tab>",
    toggle_info = "<S-Tab>",
  },
}

require("mini.extra").setup()

local process_items = function(items, base)
  return require("mini.completion").default_process_items(items, base, {
    filtersort = vim.opt.completeopt:get():find "fuzzy" and "fuzzy" or "prefix",
  })
end

require("mini.completion").setup {
  delay = {
    completion = 10000000,
    info = 200,
    signature = 50,
  },
  window = {
    info = { border = "none" },
    signature = { border = "none" },
  },
  lsp_completion = {
    source_func = "completefunc",
    auto_setup = true,
    process_items = process_items,
  },
  fallback_action = "<C-n>",
  mappings = {
    force_twostep = "",
    force_fallback = "",
    scroll_down = "",
    scroll_up = "",
  },
}

local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup {
  snippets = {
    gen_loader.from_file(vim.fs.joinpath(vim.fn.stdpath "config", "vscode", "all.json")),
    gen_loader.from_lang(),
    all_snippets,
  },
  mappings = {
    expand = "",
    jump_next = "",
    jump_prev = "",
    stop = "<C-c>",
  },
}

MiniSnippets.start_lsp_server()

require("neogen").setup {
  snippet_engine = "mini",
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

local pick = require "mini.pick"
local extra = require("mini.extra").pickers

local find_all_files = function(opts)
  return pick.builtin.cli({
    command = {
      "rg",
      "--files",
      "--hidden",
      "--glob=!**/.git/*",
    },
  }, opts)
end

vim.keymap.set("n", "<leader>fa", function()
  find_all_files()
end, { desc = "Find all files" })

vim.keymap.set("n", "<leader>fr", function()
  extra.oldfiles({ current_dir = true })
end, { desc = "Find recent files in current directory" })

vim.keymap.set("n", "<leader>ff", function()
  pick.builtin.files()
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fw", function()
  pick.builtin.grep_live()
end, { desc = "Find in project" })

vim.keymap.set("n", "<leader>fb", function()
  pick.builtin.buffers()
end, { desc = "Find buffers" })

vim.keymap.set("n", "<leader>fh", function()
  pick.builtin.help()
end, { desc = "Find help tags" })

vim.keymap.set("n", "<leader>fk", function()
  extra.keymaps()
end, { desc = "Find keymaps" })

vim.keymap.set("n", "<leader>fm", function()
  extra.marks()
end, { desc = "Find marks" })

vim.keymap.set("n", "<leader>fz", function()
  extra.buf_lines { scope = "current" }
end, { desc = "Search current buffer" })

vim.keymap.set("i", "<C-x><C-o>", function()
  require("mini.completion").complete_twostage()
end, { desc = "Show completion menu" })

vim.keymap.set("i", "<C-x><C-s>", function()
  extra.spellsuggest()
end, { desc = "Show spelling completions" })

vim.keymap.set("i", "<C-j>", snippet_expand_or_jump, { expr = true, desc = "Expand snippet or jump forward" })
vim.keymap.set("i", "<C-k>", snippet_jump "prev", { expr = true, desc = "Jump backward in snippet" })
vim.keymap.set("s", "<C-j>", snippet_jump "next", { expr = true, desc = "Jump forward in snippet" })
vim.keymap.set("s", "<C-k>", snippet_jump "prev", { expr = true, desc = "Jump backward in snippet" })

vim.keymap.set("i", "<C-b>", completion_scroll("up", "<C-b>"), { expr = true, desc = "Scroll completion documentation up" })
vim.keymap.set("i", "<C-f>", completion_scroll("down", "<C-f>"), { expr = true, desc = "Scroll completion documentation down" })

vim.keymap.set("n", "<leader>ca", function()
  require("neogen").generate()
end, { desc = "Generate code annotation" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("MiniMaxLspMappings", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "grr", function()
      extra.lsp { scope = "references" }
    end, { buffer = args.buf, desc = "LSP: find references" })
    vim.keymap.set("n", "gri", function()
      extra.lsp { scope = "implementation" }
    end, { buffer = args.buf, desc = "LSP: find implementations" })
    vim.keymap.set("n", "grt", function()
      extra.lsp { scope = "type_definition" }
    end, { buffer = args.buf, desc = "LSP: type definitions" })
    vim.keymap.set("n", "gO", function()
      extra.lsp { scope = "document_symbol" }
    end, { buffer = args.buf, desc = "LSP: document symbols" })
    vim.keymap.set("n", "gd", function()
      extra.lsp { scope = "definition" }
    end, { buffer = args.buf, desc = "Go to definition" })
  end,
})

require("filebrowser").set_local_file_picker(function(cwd)
  pick.builtin.files({}, with_cwd(cwd))
end, "OilMiniPickLocalFiles")
