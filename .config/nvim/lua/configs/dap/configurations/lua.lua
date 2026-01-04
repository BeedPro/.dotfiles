return {
  {
    name = "Current file (local-lua-dbg, lua)",
    type = "local-lua",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = {
      lua = "lua5.1",
      file = "${file}",
    },
    args = {},
  },
}
