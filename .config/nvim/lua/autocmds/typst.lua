local autocmd = vim.api.nvim_create_autocmd
local slipbox_dir = require("configs.typst").slipbox_dir() .. "/"

autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = "*.typ",
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= "" then
      return
    end

    local filepath = vim.api.nvim_buf_get_name(ev.buf)

    if filepath == "" then
      return
    end

    if vim.fn.filereadable(filepath) == 0 then
      return
    end

    local dir = vim.fn.fnamemodify(filepath, ":h")
    local outpath = dir .. "/render.pdf"

    vim.fn.jobstart({ "typst", "compile", filepath, outpath }, {
      cwd = dir,
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        if data and #data > 0 then
          print(table.concat(data, "\n"))
        end
      end,
      on_stderr = function(_, data)
        if data and #data > 0 then
          print(table.concat(data, "\n"))
        end
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = slipbox_dir .. "*",
  callback = function()
    -- load once per session
    if vim.g.slipbox_mappings_loaded then
      return
    end

    vim.g.slipbox_mappings_loaded = true
    require "mappings.typst"
  end,
})
