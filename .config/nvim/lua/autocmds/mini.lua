local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local setup_hipatterns_hl = function()
  local invert_group = function(name)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
    if not ok or type(hl) ~= "table" then
      return
    end

    local new_fg = hl.bg or hl.fg
    if not new_fg then
      return
    end

    vim.api.nvim_set_hl(0, name, {
      fg = new_fg,
      bg = "NONE",
      bold = hl.bold,
      italic = hl.italic,
      underline = hl.underline,
      undercurl = hl.undercurl,
      strikethrough = hl.strikethrough,
      nocombine = hl.nocombine,
    })
  end

  invert_group "MiniHipatternsFixme"
  invert_group "MiniHipatternsHack"
  invert_group "MiniHipatternsTodo"
  invert_group "MiniHipatternsNote"
end

autocmd("ColorScheme", {
  group = augroup("MiniHipatternsColorScheme", { clear = true }),
  callback = function()
    vim.schedule(setup_hipatterns_hl)
  end,
})
