local map = vim.keymap.set

local function should_toggle_spell_with_arabic()
  if vim.b._arabic_toggle_manages_spell == nil then
    vim.b._arabic_toggle_manages_spell = vim.wo.spell
  end

  return vim.b._arabic_toggle_manages_spell
end

map("n", "<leader>ta", function()
  if vim.wo.arabic then
    if should_toggle_spell_with_arabic() then
      vim.cmd "set spell"
    end
    vim.cmd "set noarab"
    return
  end

  if should_toggle_spell_with_arabic() then
    vim.cmd "set nospell"
  end
  vim.cmd "set arab"
end, { desc = "[T]oggle [A]rabic" })

map("i", "<C-^>", function()
  if vim.wo.arabic then
    if should_toggle_spell_with_arabic() then
      vim.cmd "set spell"
    end
    return vim.api.nvim_replace_termcodes("<C-o>:set noarab<CR>", true, false, true)
  end

  if should_toggle_spell_with_arabic() then
    vim.cmd "set nospell"
  end
  return vim.api.nvim_replace_termcodes("<C-o>:set arab<CR>", true, false, true)
end, { expr = true, desc = "Toggle arabic" })
