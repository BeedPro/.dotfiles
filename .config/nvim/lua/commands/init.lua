require "commands.mason"
require "commands.typst"
require "commands.godot"

local command = vim.api.nvim_create_user_command

command("PackUpdate", function()
  vim.pack.update()
end, {
  desc = "Update managed vim.pack plugins",
})
