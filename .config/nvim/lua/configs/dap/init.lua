local dap = require "dap"

require "configs.dap.adapters.codelldb"
require "configs.dap.adapters.local_lua"
require "configs.dap.adapters.godot"

require "configs.dap.ui"

dap.configurations.cpp = require "configs.dap.configurations.cpp"
dap.configurations.lua = require "configs.dap.configurations.lua"
dap.configurations.gdscript = require "configs.dap.configurations.godot"
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
