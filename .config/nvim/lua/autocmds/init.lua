local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

require "autocmds.ready"
require "autocmds.numbertoggle"
require "autocmds.conform"
require "autocmds.bigfile"
require "autocmds.typst"
require "autocmds.django"
require "autocmds.oil"
require "autocmds.lsp_progress"

require("autocmds.colorify").run()

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

autocmd("BufRead", {
  group = augroup("DotenvFt", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})

autocmd("PackChanged", {
  desc = "Handle nvim-treesitter updates",
  group = augroup("NvimTreesitterPackChangedUpdateHandler", { clear = true }),
  callback = function(event)
    local is_treesitter = event.data and event.data.spec and event.data.spec.name == "nvim-treesitter"
    if not is_treesitter or event.data.kind ~= "update" then
      return
    end

    vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)

    local ok = pcall(function()
      vim.cmd "TSUpdate"
    end)

    if ok then
      vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
    else
      vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
    end
  end,
})
