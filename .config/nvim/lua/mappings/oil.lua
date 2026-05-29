local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local detail = false
local oil_group = augroup("OilMappings", { clear = true })

map("n", "<leader>.", function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open()
  end
end, { desc = "Toggle file explorer" })

autocmd("FileType", {
  group = oil_group,
  pattern = "oil",
  callback = function(args)
    map("n", "gd", function()
      detail = not detail
      if detail then
        require("oil").set_columns { "permissions", "size", "mtime" }
      else
        require("oil").set_columns {}
      end
    end, { buffer = args.buf, desc = "Toggle file detail view" })

    map("n", "<leader>ff", function()
      require("fzf-lua").files {
        cwd = require("oil").get_current_dir(),
      }
    end, { buffer = args.buf, desc = "Find files in the current directory" })
  end,
})
