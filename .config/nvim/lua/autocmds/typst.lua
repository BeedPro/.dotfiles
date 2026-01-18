local autocmd = vim.api.nvim_create_autocmd

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
