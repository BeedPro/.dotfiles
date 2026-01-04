return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  cmd = "Org",
  ft = { "org" },
  config = function()
    local agenda_dir = vim.fn.expand "~/Compendium/Agenda"

    require("orgmode").setup {
      org_agenda_files = agenda_dir .. "/*",
      org_default_notes_file = agenda_dir .. "/inbox.org",

      win_split_mode = { "float", 0.85 },

      org_startup_folded = "showeverything",

      mappings = {
        org = {
          org_cycle = false,
          org_global_cycle = false,
        },
      },

      org_agenda_custom_commands = {
        d = {
          description = "Daily Agenda",
          types = {
            {
              type = "agenda",
              org_agenda_span = "day",
              org_deadline_warning_days = 7,
            },
            {
              type = "tags_todo",
              match = '+PRIORITY="A"',
              org_agenda_overriding_header = "High Priority Tasks",
            },
          },
        },
      },

      org_agenda_tags_column = 0,
      org_agenda_block_separator = "─",
      org_agenda_start_day = nil,
      org_agenda_skip_scheduled_if_done = true,
      org_agenda_skip_deadline_if_done = true,
      org_agenda_start_on_weekday = false,
      org_agenda_span = "week",

      org_capture_templates = {
        t = {
          description = "Todo",
          template = "* TODO %^{Task}\n" .. ":PROPERTIES:\n" .. ":CREATED: %U\n" .. ":END:\n" .. "%?\n",
          target = agenda_dir .. "/planner.org",
        },

        e = {
          description = "Event",
          template = "* %^{Event}\n"
            .. "TIME: %^{Event time}t\n"
            .. ":PROPERTIES:\n"
            .. ":CREATED: %U\n"
            .. ":END:\n"
            .. "%?\n",
          target = agenda_dir .. "/planner.org",
        },

        d = {
          description = "Deadline",
          template = "* TODO %^{Task}\n"
            .. "DEADLINE: %^{Deadline}t\n"
            .. ":PROPERTIES:\n"
            .. ":CREATED: %U\n"
            .. ":END:\n"
            .. "%?\n",
          target = agenda_dir .. "/planner.org",
        },

        s = {
          description = "Scheduled",
          template = "* TODO %^{Task}\n"
            .. "SCHEDULED: %^{Scheduled}t\n"
            .. ":PROPERTIES:\n"
            .. ":CREATED: %U\n"
            .. ":END:\n"
            .. "%?\n",
          target = agenda_dir .. "/planner.org",
        },

        n = {
          description = "Note",
          template = "* %^{Title}\n" .. ":PROPERTIES:\n" .. ":CREATED: %U\n" .. ":END:\n" .. "%?\n",
          target = agenda_dir .. "/inbox.org",
        },

        b = {
          description = "Bookmark",
          template = "* %x\n" .. ":PROPERTIES:\n" .. ":CREATED: %U\n" .. ":END:\n",
          target = agenda_dir .. "/bookmarks.org",
          properties = {
            empty_lines = 1,
          },
        },
      },
    }
  end,
}
