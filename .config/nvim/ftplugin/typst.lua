local opt_local = vim.opt_local
local map = vim.keymap.set

opt_local.spell = true
opt_local.spelllang = "en_gb"
opt_local.colorcolumn = "80"

local function grep_section_name_and_insert()
  local ok_builtin, builtin = pcall(require, "telescope.builtin")
  local ok_actions, actions = pcall(require, "telescope.actions")
  local ok_state, action_state = pcall(require, "telescope.actions.state")

  if not (ok_builtin and ok_actions and ok_state) then
    vim.notify("Telescope is required for Typst section lookup", vim.log.levels.ERROR)
    return
  end

  builtin.live_grep {
    default_text = '= "',
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local picker = action_state.get_current_picker(prompt_bufnr)
        local selected = picker and picker:get_multi_selection() or {}
        local entries = #selected > 0 and selected or { action_state.get_selected_entry() }

        actions.close(prompt_bufnr)

        local names = {}
        for _, entry in ipairs(entries) do
          local filename = entry and (entry.filename or entry.path or entry[1])
          if filename then
            table.insert(names, vim.fn.fnamemodify(filename, ":t:r"))
          end
        end

        if #names > 0 then
          vim.api.nvim_put({ table.concat(names, ", ") }, "c", true, true)
        end
      end)

      return true
    end,
  }
end

local current_file = vim.api.nvim_buf_get_name(0)
local parent_dir = vim.fn.fnamemodify(current_file, ":h:t")
local grandparent_dir = vim.fn.fnamemodify(current_file, ":h:h:t")

if parent_dir == "Slipbox" or (grandparent_dir == "Slipbox" and parent_dir == ".example") then
  map("i", "<C-i>", grep_section_name_and_insert, {
    buffer = true,
    desc = "Search Typst sections and insert filename",
  })
end
