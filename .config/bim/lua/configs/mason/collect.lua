local names = require "configs.mason.names"
local required = require "configs.mason.required"

local M = {}

function M.get_pkgs()
  local tools = {}
  local pkgs = vim.deepcopy(required.pkgs)

  -- Enabled native LSP configs
  if vim.lsp._enabled_configs then
    vim.list_extend(tools, vim.tbl_keys(vim.lsp._enabled_configs))
  end

  -- Configured LSP servers
  if vim.lsp.config and vim.lsp.config.available_servers then
    vim.list_extend(tools, vim.lsp.config.available_servers())
  end

  local ok_conform, conform = pcall(require, "conform")
  if ok_conform then
    for _, fmt in ipairs(conform.list_all_formatters()) do
      for _, name in ipairs(vim.split(fmt.name:gsub(",", ""), "%s+")) do
        table.insert(tools, name)
      end
    end
  end

  local ok_lint, lint = pcall(require, "lint")
  if ok_lint then
    for _, linters in pairs(lint.linters_by_ft) do
      vim.list_extend(tools, linters)
    end
  end

  for _, tool in ipairs(tools) do
    local mason_name = names[tool]
    if mason_name
      and not vim.tbl_contains(pkgs, mason_name)
      and not vim.tbl_contains(required.skip, mason_name)
    then
      table.insert(pkgs, mason_name)
    end
  end

  return pkgs
end

return M
