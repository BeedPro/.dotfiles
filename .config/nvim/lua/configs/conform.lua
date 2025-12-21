local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    typst = { "prettypst" },
    python = { "black" },
    css = { "prettierd" },
    html = { "prettierd" },
    djangohtml = { "djlint" },
    htmldjango = { "djlint" },
    markdown = { "prettierd" },
    cs = { "csharpier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    java = { "clang-format" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    typescript = { "prettierd" },
    json = { "prettierd" },
    vue = { "prettierd" },
    svelte = { "prettierd" },
    scala = { "scalafmt" },
    ["cshtml"] = { "trim_whitespace" },
    ["_"] = { "trim_whitespace" },
  },

  format_on_save = function(bufnr)
    -- Disable autoformat for scala
    if vim.bo[bufnr].filetype == "scala" then
      return nil
    end
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
}

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

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

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.html",
  callback = function(args)
    local file = args.file

    -- Complex detection logic
    if
      -- in a Django project folder
      is_django_project(file)
      -- inside typical Django template directories
      or file:match "/templates/"
      or file:match "/templates/.+%.html$"
      or file:match "/app_name/templates/"
      -- contains Django template syntax
      or html_looks_like_django(file)
    then
      vim.bo.filetype = "htmldjango"
    else
      vim.bo.filetype = "html"
    end
  end,
})
return options
