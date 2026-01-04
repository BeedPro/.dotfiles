return {
  options = {
    icons_enabled = false,
    theme = "auto",

    component_separators = "",
    section_separators = "",

    globalstatus = false,
    always_divide_middle = false,

    refresh = {
      statusline = 1000,
    },
  },

  sections = {
    lualine_a = { "mode" },

    lualine_b = {
      {},
    },

    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = {
          modified = " [+]",
          readonly = " [-]",
          unnamed = "",
        },
      },
      {
        "diff",
        symbols = {
          added = "+",
          modified = "~",
          removed = "-",
        },
      },
    },

    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {
      {
        function()
          local clients = vim.lsp.get_clients { bufnr = 0 }
          if #clients == 0 then
            return ""
          end

          local names = {}
          for _, client in ipairs(clients) do
            table.insert(names, client.name)
          end

          return table.concat(names, ", ")
        end,
      },
    },
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
