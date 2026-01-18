local command = vim.api.nvim_create_user_command
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

local function slugify(title)
  title = title:lower()
  title = title:gsub("%s+", "_")
  title = title:gsub("[^%w_]", "")
  title = title:gsub("_+", "_")
  title = title:gsub("^_+", ""):gsub("_+$", "")
  return title
end

local function make_path(path, basename)
  return path .. "/" .. basename .. ".typ"
end

local function make_note(title)
  local timestamp = os.date "%Y%m%d%H%M"
  local slug = slugify(title)
  local basename = string.format("%s-%s", timestamp, slug)
  local path = require("configs.typst").slipbox_dir()

  return basename, path
end

function M.new_main_note()
  vim.ui.input({ prompt = "Zettel title: " }, function(title)
    if not title or title == "" then
      return
    end

    local basename, path = make_note(title)
    vim.cmd("edit " .. make_path(path, basename))
  end)
end

function M.insert_note()
  vim.ui.input({ prompt = "Zettel title: " }, function(title)
    if not title or title == "" then
      return
    end

    local basename, path = make_note(title)

    -- insert filename (without extension) at cursor
    vim.api.nvim_put({ basename }, "c", true, true)

    -- open note in horizontal split
    vim.cmd("split " .. make_path(path, basename))
  end)
end

function M.open_note()
  local dir = require("configs.typst").slipbox_dir()

  -- get .typ files only (non-recursive)
  local files = vim.fn.globpath(dir, "*.typ", false, true)

  -- sort by filename descending (timestamp-first naming)
  table.sort(files, function(a, b)
    return vim.fn.fnamemodify(a, ":t") > vim.fn.fnamemodify(b, ":t")
  end)

  pickers
    .new({}, {
      prompt_title = "Slipbox",
      finder = finders.new_table {
        results = files,
        entry_maker = function(path)
          return {
            value = path,
            display = vim.fn.fnamemodify(path, ":t"),
            ordinal = path,
          }
        end,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd("edit " .. selection.value)
        end)
        return true
      end,
    })
    :find()
end

command("SlipNew", function()
  M.new_main_note()
end, { desc = "Create a new slipbox note" })

command("SlipInsert", function()
  M.insert_note()
end, { desc = "Insert slipbox note reference and open it in a split" })

command("SlipOpen", function()
  M.open_note()
end, { desc = "Open a slipbox note via Telescope" })

return M
