local dap = require "dap"

require "configs.dap.adapters.codelldb"
require "configs.dap.adapters.local_lua"

require "configs.dap.ui"

dap.configurations.cpp = require "configs.dap.configurations.cpp"
dap.configurations.lua = require "configs.dap.configurations.lua"
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
