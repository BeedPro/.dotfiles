return {
  snippets = { preset = "luasnip" },
  cmdline = {
    keymap = {
      ["<Tab>"] = { "show", "accept" },
      ["<CR>"] = { "accept_and_enter", "fallback" },
    },
    completion = {
      menu = {
        auto_show = function(ctx)
          if vim.fn.getcmdtype() ~= ":" then
            return false
          end

          local line = (ctx and ctx.line) or vim.fn.getcmdline()

          if string.find(line, "^'<,'>") then
            return false
          end

          local first_space = string.find(line, " ")
          local cmd = first_space and string.sub(line, 1, first_space - 1) or line

          if cmd == "cdo" then
            return false
          end

          if first_space then
            return true
          end

          return vim.fn.strchars(cmd) >= 4
        end,
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
    },
  },
  signature = { enabled = false },
}
