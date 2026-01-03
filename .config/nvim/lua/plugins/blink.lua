return {
  { import = "nvchad.blink.lazyspec" },
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "none",

        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },

        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
      },

      completion = {
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
}
