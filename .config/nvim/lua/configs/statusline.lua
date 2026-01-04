return {
  options = {
    icons_enabled = false,
    theme = "auto",

    component_separators = "",
    section_separators = "",

    globalstatus = true,
    always_divide_middle = false,

    refresh = {
      statusline = 1000,
    },
  },

  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "filename",
        path = 1,
      },
    },
    lualine_c = {
      "branch",
      "diagnostics",
    },

    lualine_x = {
      "diff",
      {
        "lsp_status",
        symbols = {
          spinner = {},
          done = "",
          separator = ",",
        },
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },

  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}
