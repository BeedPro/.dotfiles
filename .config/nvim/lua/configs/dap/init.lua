local dap = require "dap"

require "configs.dap.adapters.python"
require "configs.dap.adapters.codelldb"
require "configs.dap.adapters.haskell"
require "configs.dap.adapters.local_lua"
require "configs.dap.adapters.javascript"
require "configs.dap.adapters.firefox"
require "configs.dap.adapters.godot"

require "configs.dap.ui"

dap.configurations.python = require "configs.dap.configurations.python"
dap.configurations.cpp = require "configs.dap.configurations.cpp"
dap.configurations.c = dap.configurations.cpp
dap.configurations.haskell = require "configs.dap.configurations.haskell"
dap.configurations.lua = require "configs.dap.configurations.lua"
dap.configurations.javascript = require "configs.dap.configurations.javascript"
dap.configurations.javascriptreact = dap.configurations.javascript
dap.configurations.typescript = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.javascript
dap.configurations.svelte = dap.configurations.javascript
dap.configurations.gdscript = require "configs.dap.configurations.godot"
