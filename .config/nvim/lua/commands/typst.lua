local command = vim.api.nvim_create_user_command
local M = {}

local function slugify(title)
  title = title:lower()
  title = title:gsub("%s+", "_")
  title = title:gsub("[^%w_]", "")
  title = title:gsub("_+", "_")
  title = title:gsub("^_+", ""):gsub("_+$", "")
  return title
end

function M.new_main_note()
  vim.ui.input({ prompt = "Zettel title: " }, function(title)
    if not title or title == "" then
      return
    end

    local timestamp = os.date "%Y%m%d%H%M"
    local slug = slugify(title)

    local filename = string.format("%s-%s.typ", timestamp, slug)

    vim.cmd("edit ~/Compendium/Slipbox/" .. filename)
  end)
end

command("SlipNew", function()
  M.new_main_note()
end, { desc = "Create a new slipbox note" })

return M
