local godot_pfile = vim.fn.getcwd() .. "/project.godot"
if godot_pfile then
  vim.fn.serverstart "./godot.pipe"
end
