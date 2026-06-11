vim.pack.add {
  "https://github.com/rafamadriz/friendly-snippets",
}

require("mini.pick").setup {
  source = {
    show = function(buf_id, items, query)
      return require("mini.pick").default_show(buf_id, items, query, { show_icons = false })
    end,
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

require("mini.extra").setup {}

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
    process_items = function(items, base)
      return require("mini.completion").default_process_items(items, base, {
        filtersort = vim.o.completeopt:find("fuzzy", 1, true) and "fuzzy" or "prefix",
      })
    end,
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
    gen_loader.from_file(vim.fs.joinpath(vim.fn.stdpath "config", "minisnippets", "global.json")),
    gen_loader.from_lang(),
  },
  mappings = {
    expand = "<C-j>",
    jump_next = "<C-j>",
    jump_prev = "<C-k>",
    stop = "<C-e>",
  },
}

require("mini.snippets").start_lsp_server {}

local pick = require "mini.pick"
local extra = require("mini.extra").pickers

vim.keymap.set("n", "<leader>fa", function()
  pick.builtin.cli {
    command = {
      "rg",
      "--files",
      "--hidden",
      "--glob=!**/.git/*",
    },
  }
end, { desc = "Find all files" })

vim.keymap.set("n", "<leader>fr", function()
  extra.oldfiles { current_dir = true }
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

vim.keymap.set("i", "<C-b>", function()
  if require("mini.completion").scroll "up" then
    return ""
  end

  return vim.api.nvim_replace_termcodes("<C-b>", true, false, true)
end, { expr = true, desc = "Scroll completion documentation up" })

vim.keymap.set("i", "<C-f>", function()
  if require("mini.completion").scroll "down" then
    return ""
  end

  return vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
end, { expr = true, desc = "Scroll completion documentation down" })

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

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("OilMiniPickLocalFiles", { clear = true }),
  pattern = "oil",
  callback = function(args)
    vim.keymap.set("n", "<leader>ff", function()
      pick.builtin.files({}, {
        source = {
          cwd = require("oil").get_current_dir() or vim.fn.getcwd(),
        },
      })
    end, { buffer = args.buf, desc = "Find files in the current directory" })
  end,
})
