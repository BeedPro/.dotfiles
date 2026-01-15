local dap = require "dap"

require "configs.dap.adapters"
require "configs.dap.ui"

dap.configurations.cpp = require "configs.dap.configurations.cpp"
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.configurations.cs = require "configs.dap.configurations.cs"
dap.configurations.lua = require "configs.dap.configurations.lua"
