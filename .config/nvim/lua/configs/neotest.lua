local neotest = require "neotest"
neotest.setup {
  adapters = {
    require "neotest-python" {
      dap = { justMyCode = false },
      args = { "--log-level", "DEBUG" },
      runner = "pytest",
      python = ".venv/bin/python",
      pytest_discover_instances = false,
    },
    require "neotest-java",
    require "neotest-dotnet",
    require "neotest-plenary",
  },
}
