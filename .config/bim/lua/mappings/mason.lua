local pkgs = {
  -- LSP
  "clangd",
  "pyright",
  "jdtls",
  "lua-language-server",
  "roslyn",
  "tinymist",

  -- DAP
  "codelldb",
  "debugpy",
  "java-debug-adapter",
  "java-test",
  "netcoredbg",

  -- Linters
  "mypy",
  "ruff",
  "djlint",

  -- Formatters
  "prettypst",
  "black",
  "clang-format",
  "csharpier",
  "prettier",
  "prettierd",
  "stylua",
}

local function install()
  local registry = require "mason-registry"

  registry.refresh(function()
    for _, name in ipairs(pkgs) do
      local ok, pkg = pcall(registry.get_package, name)
      if ok and not pkg:is_installed() then
        pkg:install()
      end
    end
  end)
end

vim.api.nvim_create_user_command("MasonInstallAll", function()
  install()
  vim.cmd "Mason"
end, {
  desc = "Install predefined Mason packages",
})
