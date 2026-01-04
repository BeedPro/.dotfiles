return {
  "scalameta/nvim-metals",
  ft = { "scala", "sbt" },

  config = function()
    local metals = require "metals"
    local metals_config = metals.bare_config()

    metals_config.init_options = metals_config.init_options or {}
    metals_config.init_options.statusBarProvider = "off"

    metals_config.on_attach = function(client, bufnr)
      require("nvchad.configs.lspconfig").on_attach(client, bufnr)
    end

    metals_config.capabilities = require("nvchad.configs.lspconfig").capabilities

    local group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt" },
      callback = function()
        metals.initialize_or_attach(metals_config)
      end,
      group = group,
    })
  end,
}
