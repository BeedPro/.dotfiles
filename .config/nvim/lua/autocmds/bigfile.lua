local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("BigFile", { clear = true })

local max_size = 1024 * 1024 * 1.5

autocmd("BufReadPre", {
  group = group,
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    if file == "" then
      return
    end

    local ok, stat = pcall(vim.uv.fs_stat, file)
    if not ok or not stat or stat.size <= max_size then
      return
    end

    vim.b[args.buf].bigfile = true

    vim.notify(
      ("Big file detected: %.2f MiB"):format(stat.size / 1024 / 1024),
      vim.log.levels.WARN,
      { title = "BigFile" }
    )

    vim.opt_local.foldmethod = "manual"
    vim.opt_local.swapfile = false
    vim.opt_local.undofile = false
    vim.opt_local.spell = false
    vim.opt_local.list = false
  end,
})

autocmd("FileType", {
  group = group,
  callback = function(args)
    if not vim.b[args.buf].bigfile then
      return
    end

    pcall(vim.treesitter.stop, args.buf)
    pcall(vim.api.nvim_buf_call, args.buf, function()
      vim.cmd.syntax "off"
    end)
  end,
})
