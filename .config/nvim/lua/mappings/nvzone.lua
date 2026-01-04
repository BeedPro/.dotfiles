local map = vim.keymap.set

map({ "n", "v" }, "<RightMouse>", function()
  require("menu.utils").delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  require("menu").open("default", { mouse = true })
end, {})
