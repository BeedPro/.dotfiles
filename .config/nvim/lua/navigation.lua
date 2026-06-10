vim.pack.add {
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/stevearc/oil.nvim",
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

require("oil").setup {
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
  },
  columns = {},
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
vim.keymap.set("n", "<leader>.", function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open()
  end
end, { desc = "Toggle file explorer" })

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
    vim.keymap.set("n", "gd", function()
      require("fzf-lua").lsp_definitions()
    end, { buffer = args.buf, desc = "Go to definition" })
  end,
})

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
