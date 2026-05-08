local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function is_django_project(filepath)
  -- Walk up directories to find "manage.py" or "settings.py"
  local dir = vim.fn.fnamemodify(filepath, ":p:h")

  while dir do
    local manage_py = vim.fs.joinpath(dir, "manage.py")
    local settings_py = vim.fs.joinpath(dir, "project", "settings.py")
    local settings_glob = vim.fn.glob(vim.fs.joinpath(dir, "**", "settings.py"))

    if vim.uv.fs_stat(manage_py) or vim.uv.fs_stat(settings_py) or settings_glob ~= "" then
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
  if vim.fn.filereadable(filepath) ~= 1 then
    return false
  end

  local lines = vim.fn.readfile(filepath, "", 20) -- read first 20 lines
  for _, line in ipairs(lines) do
    if line:match "{%%" or line:match "{{" or line:match "{#" then
      return true
    end
  end
  return false
end

autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("DjangoHtmlFt", { clear = true }),
  pattern = "*.html",
  callback = function(args)
    local file = args.file
    local normalized = file:gsub("\\", "/")

    if
      is_django_project(normalized)
      or normalized:match "/templates/"
      or normalized:match "/templates/.+%.html$"
      or normalized:match "/app_name/templates/"
      or html_looks_like_django(normalized)
    then
      vim.bo.filetype = "htmldjango"
    else
      vim.bo.filetype = "html"
    end
  end,
})
