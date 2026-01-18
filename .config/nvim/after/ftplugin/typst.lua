local o = vim.o
o.spell = true
o.spelllang = "en_gb"

local map = vim.keymap.set
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
      finder = finders.new_oneshot_job(
        { "rg", "--files", "--maxdepth", "1", "--glob", "*.typ" },
        { cwd = vim.fn.expand "%:p:h" }
      ),
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

map("n", "<space>frb", function()
  local name = vim.fn.expand "%:t:r"
  if name == "" then
    return
  end
  builtin.live_grep { default_text = name }
end, { desc = "[F]ind [R]oam [B]acklinks" })

map("i", "<C-f>", function()
  insert_filename()
end, { desc = "Insert filename via Telescope" })
