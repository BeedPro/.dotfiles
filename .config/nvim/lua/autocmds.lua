require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local command = vim.api.nvim_create_user_command

local diagnosticGroup = augroup("DiagnosticFloat", { clear = true })
local numtogglegroup = augroup("numbertoggle", {}) --- sitiom/nvim-numbertoggle

local function open_diagnostic_float()
  vim.diagnostic.open_float(nil, { focus = false })
end

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

local function is_django_project(filepath)
  local uv = vim.loop

  -- Walk up directories to find "manage.py" or "settings.py"
  local dir = vim.fn.fnamemodify(filepath, ":p:h")

  while dir and dir ~= "/" do
    local manage_py = dir .. "/manage.py"
    local settings_py = dir .. "/project/settings.py" -- common layout
    local settings_glob = vim.fn.glob(dir .. "/**/settings.py")

    if uv.fs_stat(manage_py) or uv.fs_stat(settings_py) or settings_glob ~= "" then
      return true
    end

    -- Move up one directory
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end

  return false
end

local function html_looks_like_django(filepath)
  local lines = vim.fn.readfile(filepath, "", 20) -- read first 20 lines
  for _, line in ipairs(lines) do
    if line:match "{%%" or line:match "{{" or line:match "{#" then
      return true
    end
  end
  return false
end

--- Commands
command("Format", function()
  require("conform").format { async = true, lsp_fallback = true }
end, {})

command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.html",
  callback = function(args)
    local file = args.file

    if
      is_django_project(file)
      or file:match "/templates/"
      or file:match "/templates/.+%.html$"
      or file:match "/app_name/templates/"
      or html_looks_like_django(file)
    then
      vim.bo.filetype = "htmldjango"
    else
      vim.bo.filetype = "html"
    end
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

autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = "*.typ",
  callback = function(ev)
    local filepath = vim.api.nvim_buf_get_name(ev.buf)

    -- Always output to "render.pdf" in the same directory
    local dir = vim.fn.fnamemodify(filepath, ":h")
    local outpath = dir .. "/render.pdf"

    -- Run typst compile
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

autocmd("VimEnter", {
  callback = open_on_start,
})

autocmd("FileType", {
  pattern = "org",
  callback = function()
    vim.keymap.set("i", "<S-CR>", '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
      silent = true,
      buffer = true,
    })
  end,
})

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

autocmd("CursorHold", {
  group = diagnosticGroup,
  callback = open_diagnostic_float,
})

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = numtogglegroup,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = numtogglegroup,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
      -- Workaround for https://github.com/neovim/neovim/issues/32068
      if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
        vim.cmd "redraw"
      end
    end
  end,
})
