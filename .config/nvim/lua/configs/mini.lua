local sessions = require "mini.sessions"
sessions.setup {}

local starter = require "mini.starter"
starter.setup {
  evaluate_single = true,
  items = {
    starter.sections.builtin_actions(),
    starter.sections.recent_files(10, true),
    starter.sections.sessions(5, true),
  },
}
