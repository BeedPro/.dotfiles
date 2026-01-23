local command = vim.api.nvim_create_user_command

local function find_godot_project_root()
  local cwd = vim.fn.getcwd()
  local search_paths = { "", "/.." }

  for _, relative_path in ipairs(search_paths) do
    local project_file = cwd .. relative_path .. "/project.godot"
    if vim.uv.fs_stat(project_file) then
      return cwd .. relative_path
    end
  end

  return nil
end

local function is_server_running(project_path)
  local server_pipe = project_path .. "/server.pipe"
  return vim.uv.fs_stat(server_pipe) ~= nil
end

local function start_godot_server_if_needed()
  local godot_project_path = find_godot_project_root()

  if not godot_project_path then
    vim.notify("Not inside a Godot project", vim.log.levels.WARN)
    return
  end

  if is_server_running(godot_project_path) then
    vim.notify "Godot Neovim server already running"
    return
  end

  vim.fn.serverstart(godot_project_path .. "/server.pipe")
  vim.notify "Godot Neovim server started"
end

command(
  "GodotServerStart",
  start_godot_server_if_needed,
  { desc = "Start Neovim server for Godot project if not already running" }
)
