return {
  {
    name = "Launch file (lua)",
    type = "local-lua",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = {
      lua = "lua",
      file = "${file}",
    },
    args = {},
  },
  {
    name = "Launch file (luajit)",
    type = "local-lua",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = {
      lua = "luajit",
      file = "${file}",
    },
    args = {},
  },
}
