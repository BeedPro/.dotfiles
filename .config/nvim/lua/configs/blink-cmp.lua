return {
  snippets = { preset = "luasnip" },
  cmdline = { enabled = true },
  appearance = { nerd_font_variant = "normal" },
  fuzzy = { implementation = "prefer_rust" },
  sources = {
    default = { "lsp", "snippets", "buffer", "path" },
    providers = {
      spell = {
        name = "Spell",
        module = "blink-cmp-spell",
        opts = {
          max_entries = 20,
          keep_all_entries = true,
        },
      },
    },
  },

  keymap = {
    preset = "none",

    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "accept", "fallback" },

    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },

    ["<Up>"] = { "scroll_documentation_up", "fallback" },
    ["<Down>"] = { "scroll_documentation_down", "fallback" },

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
    menu = {
      auto_show = false,
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind" },
        },
      },
    },
  },
  signature = { enabled = true },
}
