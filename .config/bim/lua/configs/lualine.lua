require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_c = {
      {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return "No LSP"
          end
          return "  " .. clients[1].name
        end,
      },
      { "diagnostics" }
    },
    lualine_x = {},
    lualine_y = { "branch" },
    lualine_z = { "location" }
  },
})
