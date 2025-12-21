local nvlsp = require "nvchad.configs.lspconfig"
local jdtls = require "jdtls"
local autocmd = vim.api.nvim_create_autocmd
local jdtls_command_path = vim.fn.expand "~/.local/share/nvim/mason/bin/jdtls"
local config = {
  cmd = { jdtls_command_path },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  on_attach = nvlsp.on_attach,
}

jdtls.start_or_attach(config)

autocmd({ "BufEnter" }, {
  pattern = "*.java",
  callback = function()
    jdtls.start_or_attach(config)
  end,
})
