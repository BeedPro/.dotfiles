local autocmd = vim.api.nvim_create_autocmd

require "autocmds.ready"
require "autocmds.numbertoggle"
require "autocmds.conform"
require "autocmds.typst"
require "autocmds.django"
require "autocmds.oil"

require("autocmds.colorify").run()

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

autocmd({ "BufReadPost" }, {
  pattern = table.concat(
    vim.tbl_map(function(ext)
      return "*." .. ext
    end, {
      "pdf",
      "png",
      "jpg",
      "jpeg",
      "gif",
      "bmp",
      "svg",
      "xopp",
    }),
    ","
  ),
  callback = function()
    local open_cmd
    if vim.fn.has "mac" == 1 then
      open_cmd = "open"
    elseif vim.fn.has "win32" == 1 then
      open_cmd = "start"
    else
      open_cmd = "xdg-open"
    end
    local file = vim.fn.expand "%:p"
    vim.fn.jobstart({ open_cmd, file }, { detach = true })
    vim.schedule(function()
      vim.cmd "bdelete!"
    end)
  end,
})
