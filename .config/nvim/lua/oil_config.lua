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
