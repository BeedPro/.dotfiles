vim.pack.add {
  "https://github.com/nvim-mini/mini.nvim",
}

require("mini.sessions").setup {
  force = { read = false, write = true, delete = true },
}

require("mini.hipatterns").setup {
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color { style = "inline", inline_text = "█ " },
  },
}

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("MiniHipatternsColorScheme", { clear = true }),
  callback = function()
    vim.schedule(function()
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "MiniHipatternsFixme", link = false })
      if ok and type(hl) == "table" and (hl.bg or hl.fg) then
        vim.api.nvim_set_hl(0, "MiniHipatternsFixme", {
          fg = hl.bg or hl.fg,
          bg = "NONE",
          bold = hl.bold,
          italic = hl.italic,
          underline = hl.underline,
          undercurl = hl.undercurl,
          strikethrough = hl.strikethrough,
          nocombine = hl.nocombine,
        })
      end
      ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "MiniHipatternsHack", link = false })
      if ok and type(hl) == "table" and (hl.bg or hl.fg) then
        vim.api.nvim_set_hl(0, "MiniHipatternsHack", {
          fg = hl.bg or hl.fg,
          bg = "NONE",
          bold = hl.bold,
          italic = hl.italic,
          underline = hl.underline,
          undercurl = hl.undercurl,
          strikethrough = hl.strikethrough,
          nocombine = hl.nocombine,
        })
      end
      ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "MiniHipatternsTodo", link = false })
      if ok and type(hl) == "table" and (hl.bg or hl.fg) then
        vim.api.nvim_set_hl(0, "MiniHipatternsTodo", {
          fg = hl.bg or hl.fg,
          bg = "NONE",
          bold = hl.bold,
          italic = hl.italic,
          underline = hl.underline,
          undercurl = hl.undercurl,
          strikethrough = hl.strikethrough,
          nocombine = hl.nocombine,
        })
      end
      ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "MiniHipatternsNote", link = false })
      if ok and type(hl) == "table" and (hl.bg or hl.fg) then
        vim.api.nvim_set_hl(0, "MiniHipatternsNote", {
          fg = hl.bg or hl.fg,
          bg = "NONE",
          bold = hl.bold,
          italic = hl.italic,
          underline = hl.underline,
          undercurl = hl.undercurl,
          strikethrough = hl.strikethrough,
          nocombine = hl.nocombine,
        })
      end
    end)
  end,
})
