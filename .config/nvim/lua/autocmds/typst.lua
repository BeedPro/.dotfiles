local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = "*.typ",
  callback = function(ev)
    local filepath = vim.api.nvim_buf_get_name(ev.buf)

    -- Always output to "render.pdf" in the same directory
    local dir = vim.fn.fnamemodify(filepath, ":h")
    local outpath = dir .. "/render.pdf"

    local cmd = { "typst", "compile", filepath, outpath }
    vim.fn.jobstart(cmd, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        if data then
          print(table.concat(data, "\n"))
        end
      end,
      on_stderr = function(_, data)
        if data then
          print(table.concat(data, "\n"))
        end
      end,
    })
  end,
})
