local ls = require "luasnip"
local config_path = vim.fn.stdpath "config"
local lua_snippets_path = vim.fs.joinpath(config_path, "snippets", "luasnips")
local snipmate_snippets_path = vim.fs.joinpath(config_path, "snippets", "snipmate")
local vscode_snippets_path = vim.fs.joinpath(config_path, "snippets", "vscode")

local vscode_snippets_exclude = {}

ls.config.set_config { history = true, updateevents = "TextChanged,TextChangedI" }

require("luasnip.loaders.from_vscode").lazy_load {
  exclude = vscode_snippets_exclude,
  fs_event_providers = { autocmd = true, libuv = true },
}

require("luasnip.loaders.from_vscode").lazy_load {
  paths = { vscode_snippets_path },
  fs_event_providers = { autocmd = true, libuv = true },
}

if snipmate_snippets_path then
  require("luasnip.loaders.from_snipmate").lazy_load {
    paths = { snipmate_snippets_path },
    fs_event_providers = { autocmd = true, libuv = true },
  }
end

require("luasnip.loaders.from_lua").lazy_load {
  paths = { lua_snippets_path },
  fs_event_providers = { autocmd = true, libuv = true },
}
