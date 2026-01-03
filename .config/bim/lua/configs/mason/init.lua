local collect = require "configs.mason.collect"

local M = {}

local function parse_package(package)
  local name, version = package:match "^([^@]+)@?(.*)$"
  return {
    name = name,
    version = version ~= "" and version or nil,
  }
end

function M.install_all()
  local registry = require "mason-registry"

  registry.refresh(function()
    for _, tool in ipairs(collect.get_pkgs()) do
      local pkg = parse_package(tool)
      local p = registry.get_package(pkg.name)

      if not p:is_installed() then
        p:install { version = pkg.version }
      end
    end
  end)
end

function M.setup()
  vim.api.nvim_create_user_command("MasonInstallAll", function()
    -- ensure mason is loaded
    require("lazy").load { plugins = { "mason.nvim" } }
    M.install_all()
  end, {
    desc = "Install all required Mason tools",
  })
end

return M
