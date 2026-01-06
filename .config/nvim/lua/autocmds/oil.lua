local autocmd = vim.api.nvim_create_autocmd

local function open_on_start(data)
  local is_dir = vim.fn.isdirectory(data.file) == 1
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not is_dir and not no_name then
    return
  end

  if is_dir then
    vim.schedule(function()
      vim.cmd.cd(data.file)
      vim.cmd("Oil " .. vim.fn.fnameescape(data.file))
    end)
  end
end

autocmd("VimEnter", {
  callback = open_on_start,
})
