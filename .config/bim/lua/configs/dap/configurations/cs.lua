return {
  {
    type = "coreclr",
    name = "Launch .NET Core App",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
}
