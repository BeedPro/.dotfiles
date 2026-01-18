local o = vim.o
o.spell = true
o.spelllang = "en_gb"

local map = vim.keymap.set
local command = vim.api.nvim_create_user_command
local builtin = require "telescope.builtin"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local function insert_filename()
  pickers
    .new({}, {
      prompt_title = "Insert file",
      finder = finders.new_oneshot_job({ "rg", "--files", "--glob", "*.typ" }, { cwd = vim.fn.getcwd() }),
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection and selection[1] then
            -- basename without extension
            local basename = vim.fn.fnamemodify(selection[1], ":t:r")
            vim.api.nvim_put({ basename }, "", true, true)
          end
        end)
        return true
      end,
    })
    :find()
end

local function slugify(title)
  title = title:lower()
  title = title:gsub("%s+", "_")
  title = title:gsub("[^%w_]", "")
  title = title:gsub("_+", "_")
  title = title:gsub("^_+", ""):gsub("_+$", "")
  return title
end

local function new_zettel()
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

command("ZettelNew", function()
  new_zettel()
end, {})

map("n", "<space>frb", function()
  local name = vim.fn.expand "%:t:r"
  if name == "" then
    return
  end
  builtin.live_grep { default_text = name }
end, { desc = "Search '(filename)' (no ext)" })

map("i", "<C-f>", function()
  insert_filename()
end, { desc = "Insert filename via Telescope" })
