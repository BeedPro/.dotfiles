return {
  snippets = { preset = "luasnip" },
  cmdline = {
    keymap = {
      ["<Tab>"] = { "show", "select_next" },
    },
    completion = {
      menu = {
        auto_show = false,
      },
      list = {
        selection = {
          preselect = false,
        },
      },
    },
  },
  appearance = {
    nerd_font_variant = "mono",
    kind_icons = {
      Text = "[T]",
      Method = "[M]",
      Function = "[F]",
      Constructor = "[C]",
      Field = "[Fd]",
      Variable = "[V]",
      Property = "[P]",
      Class = "[Cl]",
      Interface = "[I]",
      Struct = "[St]",
      Module = "[Mo]",
      Unit = "[U]",
      Value = "[Val]",
      Enum = "[E]",
      EnumMember = "[Em]",
      Keyword = "[K]",
      Constant = "[Co]",
      Snippet = "[S]",
      Color = "[Col]",
      File = "[Fi]",
      Reference = "[R]",
      Folder = "[Dir]",
      Event = "[Ev]",
      Operator = "[Op]",
      TypeParameter = "[Tp]",
    },
  },
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

    ["<C-f>"] = { "scroll_documentation_up", "fallback" },
    ["<C-b>"] = { "scroll_documentation_down", "fallback" },

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
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      auto_show = false,
    },
  },
  signature = { enabled = false },
}
