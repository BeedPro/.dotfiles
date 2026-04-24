local ls = require "luasnip"

ls.config.set_config { history = true, updateevents = "TextChanged,TextChangedI" }

-- vscode format
require("luasnip.loaders.from_vscode").lazy_load {
  exclude = vim.g.vscode_snippets_exclude or {},
  fs_event_providers = { autocmd = true, libuv = true },
}

require("luasnip.loaders.from_vscode").lazy_load {
  paths = { vim.g.vscode_snippets_path },
  fs_event_providers = { autocmd = true, libuv = true },
}

-- snipmate format (enable if you use snipmate snippets)
if vim.g.snipmate_snippets_path then
  require("luasnip.loaders.from_snipmate").lazy_load {
    paths = { vim.g.snipmate_snippets_path },
    fs_event_providers = { autocmd = true, libuv = true },
  }
end

-- lua format
require("luasnip.loaders.from_lua").lazy_load {
  paths = { vim.g.lua_snippets_path },
  fs_event_providers = { autocmd = true, libuv = true },
}

-- fix luasnip #258
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if
      ls.session.current_nodes[vim.api.nvim_get_current_buf()]
      and not ls.session.jump_active
    then
      ls.unlink_current()
    end
  end,
})
