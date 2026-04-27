local godot_pfile = vim.fn.getcwd() .. "/project.godot"
if vim.fn.filereadable(godot_pfile) == 1 then
  vim.fn.serverstart "./godot.pipe"
end
