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

require("filebrowser").set_local_file_picker(function(cwd)
  require("fzf-lua").files { cwd = cwd }
end, "OilFzfLocalFiles")
