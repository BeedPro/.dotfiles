vim.pack.add {
  "https://github.com/mason-org/mason.nvim",
}

local M = {}
local packages = {}

require("mason").setup {
  PATH = "skip",
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
  ui = {
    backdrop = 100,
    icons = {
      package_pending = "[.] ",
      package_installed = "[+] ",
      package_uninstalled = "[ ] ",
    },
  },
  max_concurrent_installers = 10,
}

function M.add(items)
  vim.list_extend(packages, items)
end

vim.api.nvim_create_user_command("MasonInstallAll", function()
  require("mason-registry").refresh(function()
    for _, name in ipairs(packages) do
      if pcall(require("mason-registry").get_package, name)
        and not select(2, pcall(require("mason-registry").get_package, name)):is_installed()
      then
        select(2, pcall(require("mason-registry").get_package, name)):install()
      end
    end
  end)
  vim.cmd "Mason"
end, {
  desc = "Install enabled Mason packages",
})

return M
