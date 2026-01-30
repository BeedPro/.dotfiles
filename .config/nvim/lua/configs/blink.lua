local opts = {
  snippets = { preset = "luasnip" },
  cmdline = { enabled = true },
  appearance = { nerd_font_variant = "normal" },
  fuzzy = { implementation = "prefer_rust" },
  sources = { default = { "lsp", "snippets", "buffer", "path" } },

  keymap = {
    preset = "none",

    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "accept", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<C-j>"] = { "snippet_forward", "fallback" },
    ["<C-k>"] = { "snippet_backward", "fallback" },
  },

  completion = {
    ghost_text = { enabled = false },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "single" },
    },
  },
}

return opts
