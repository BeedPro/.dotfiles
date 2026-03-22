local command = vim.api.nvim_create_user_command

command("PackUpdate", function()
  vim.pack.update()
end, {
  desc = "Update managed vim.pack plugins",
})

local plugin_repo = function(src)
  local clean = src:gsub("%.git$", ""):gsub("/$", "")
  return clean:match("[/:]([^/:]+/[^/:]+)$") or clean
end

command("PackList", function(opts)
  if opts.args == "verbose" then
    vim.print(vim.pack.get())
    return
  end

  local plugins = vim.pack.get(nil, { info = false })
  local repos = {}

  for _, plugin in ipairs(plugins) do
    repos[#repos + 1] = plugin_repo(plugin.spec.src)
  end

  table.sort(repos)

  if #repos == 0 then
    vim.notify("No managed plugins found", vim.log.levels.INFO, { title = "PackList" })
    return
  end

  for _, repo in ipairs(repos) do
    print(repo)
  end
end, {
  desc = "List managed vim.pack plugins",
  nargs = "?",
  complete = function()
    return { "verbose" }
  end,
})
