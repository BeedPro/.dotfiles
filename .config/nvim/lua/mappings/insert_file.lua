local function insert_filename()
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values

  pickers
    .new({}, {
      prompt_title = "Insert file",
      finder = finders.new_oneshot_job({ "rg", "--files" }, { cwd = vim.fn.getcwd() }),
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

local map = vim.keymap.set

map("i", "<C-f>", function()
  insert_filename()
end, { desc = "Insert filename via Telescope" })
