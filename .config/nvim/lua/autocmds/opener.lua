local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local opener_ext = {
  png = true,
  jpg = true,
  jpeg = true,
  gif = true,
  webp = true,
  svg = true,
  bmp = true,
  ico = true,
  pdf = true,
  mp4 = true,
  mkv = true,
  mov = true,
  avi = true,
  webm = true,
  mp3 = true,
  wav = true,
  flac = true,
  ogg = true,
}

autocmd("BufReadPost", {
  group = augroup("OpenBinaryExternally", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    local path = vim.api.nvim_buf_get_name(args.buf)
    if path == "" then
      return
    end

    if path:match "^%w+://" then
      return
    end

    local ext = vim.fn.fnamemodify(path, ":e"):lower()
    if not opener_ext[ext] then
      return
    end

    vim.fn.jobstart({ "xdg-open", path }, { detach = true })

    vim.schedule(function()
      if vim.api.nvim_get_current_buf() ~= args.buf then
        return
      end

      pcall(vim.cmd, "silent! b#")

      if vim.api.nvim_get_current_buf() == args.buf then
        pcall(vim.cmd, "silent! enew")
      end

      pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
    end)
  end,
})
