local command = vim.api.nvim_create_user_command
local pkgs = require "configs.mason.required"

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

command("MasonInstallAll", function()
  install()
  vim.cmd "Mason"
end, {
  desc = "Install predefined Mason packages",
})
