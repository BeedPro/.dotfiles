local org_dir = vim.fs.normalize(vim.fn.expand "~/Compendium/Journal")
local sep = package.config:sub(1, 1)
local capture_file = org_dir .. sep .. "capture.org"
local compass_file = org_dir .. sep .. "compass.org"

require("orgmode").setup {
  org_agenda_files = { capture_file, compass_file },
  org_default_notes_file = capture_file,
  org_todo_keywords = { "TODO(t)", "NEXT(n)", "WAITING(w)", "|", "DONE(d)", "CANCELLED(c)" },
  org_ellipsis = "...",
  org_startup_folded = "content",
  org_startup_indented = true,
  org_hide_leading_stars = true,
  org_adapt_indentation = false,
  org_log_done = "time",
  org_log_into_drawer = "LOGBOOK",
  org_edit_src_content_indentation = 0,
  win_split_mode = "edit",
  org_capture_templates = {
    t = {
      description = "Task",
      template = "** TODO %<%H%M%S> - %?",
      target = capture_file,
      datetree = {
        reversed = true,
        tree_type = "custom",
        tree = {
          {
            format = "%Y%m%d",
            pattern = "^(%d%d%d%d)(%d%d)(%d%d)$",
            order = { 1, 2, 3 },
          },
        },
      },
      properties = { empty_lines = { before = 0, after = 0 } },
    },
    n = {
      description = "Note",
      template = "** %<%H%M%S> - %?",
      target = capture_file,
      datetree = {
        reversed = true,
        tree_type = "custom",
        tree = {
          {
            format = "%Y%m%d",
            pattern = "^(%d%d%d%d)(%d%d)(%d%d)$",
            order = { 1, 2, 3 },
          },
        },
      },
      properties = { empty_lines = { before = 0, after = 0 } },
    },
  },
  mappings = {
    global = {
      org_agenda = { "<Leader>oa" },
      org_capture = { "<Leader>oc" },
    },
    org = {
      org_store_link = { "<Leader>ol" },
    },
  },
}

vim.lsp.enable "org"
