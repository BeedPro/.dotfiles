vim.pack.add {
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
}

local M = {}
local mason_packages = {}

require("lazydev").setup {
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
}

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

vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          preselectSupport = true,
          commitCharactersSupport = true,
          resolveSupport = {
            properties = {
              "documentation",
              "detail",
              "additionalTextEdits",
            },
          },
        },
      },
    },
  },
})

vim.diagnostic.config {
  underline = false,
}

vim.lsp.document_color.enable(false)

function M.enable(servers)
  vim.lsp.enable(servers)
end

function M.mason(packages)
  vim.list_extend(mason_packages, packages)
end

function M.pack_add(packages)
  vim.pack.add(packages)
end

vim.api.nvim_create_user_command("MasonInstallAll", function()
  require("mason-registry").refresh(function()
    for _, name in ipairs(mason_packages) do
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
