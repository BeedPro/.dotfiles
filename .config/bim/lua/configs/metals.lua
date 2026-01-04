local metals = require "metals"
local metals_config = metals.bare_config()

metals_config.init_options = metals_config.init_options or {}
metals_config.init_options.statusBarProvider = "off"

metals_config.on_attach = require("configs.lsp.attach").on_attach

metals_config.capabilities = require("configs.lsp.capabilities").capabilities

local group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = group,
})
