local ls = require "luasnip"

ls.config.set_config { history = true, updateevents = "TextChanged,TextChangedI" }

require("luasnip.loaders.from_vscode").lazy_load {
  exclude = vim.g.vscode_snippets_exclude or {},
  fs_event_providers = { autocmd = true, libuv = true },
}

require("luasnip.loaders.from_vscode").lazy_load {
  paths = { vim.g.vscode_snippets_path },
  fs_event_providers = { autocmd = true, libuv = true },
}

if vim.g.snipmate_snippets_path then
  require("luasnip.loaders.from_snipmate").lazy_load {
    paths = { vim.g.snipmate_snippets_path },
    fs_event_providers = { autocmd = true, libuv = true },
  }
end

require("luasnip.loaders.from_lua").lazy_load {
  paths = { vim.g.lua_snippets_path },
  fs_event_providers = { autocmd = true, libuv = true },
}
