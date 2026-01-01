require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      { "filename", path = 1 },
      {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return "No LSP"
          end
          return "  " .. clients[1].name
        end,
      }
    },
    lualine_x = {
      "diagnostics",
      "encoding",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
