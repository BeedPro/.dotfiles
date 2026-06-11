local pick = require "mini.pick"
local extra = require "mini.extra"

pick.setup {
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

extra.setup {}

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
  extra.pickers.oldfiles { current_dir = true }
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
  extra.pickerskeymaps()
end, { desc = "Find keymaps" })

vim.keymap.set("n", "<leader>fm", function()
  extra.pickersmarks()
end, { desc = "Find marks" })

vim.keymap.set("n", "<leader>fz", function()
  extra.pickersbuf_lines { scope = "current" }
end, { desc = "Search current buffer" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("MiniMaxLspMappings", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "grr", function()
      extra.pickerslsp { scope = "references" }
    end, { buffer = args.buf, desc = "LSP: find references" })

    vim.keymap.set("n", "gri", function()
      extra.pickerslsp { scope = "implementation" }
    end, { buffer = args.buf, desc = "LSP: find implementations" })

    vim.keymap.set("n", "grt", function()
      extra.pickerslsp { scope = "type_definition" }
    end, { buffer = args.buf, desc = "LSP: type definitions" })

    vim.keymap.set("n", "gO", function()
      extra.pickerslsp { scope = "document_symbol" }
    end, { buffer = args.buf, desc = "LSP: document symbols" })

    vim.keymap.set("n", "gd", function()
      extra.pickerslsp { scope = "definition" }
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
