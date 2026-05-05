local sessions = require "mini.sessions"
sessions.setup {
  force = { read = false, write = true, delete = true },
}

local hipatterns = require "mini.hipatterns"
hipatterns.setup {
  highlighters = {
    fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
    hack = { pattern = "HACK", group = "MiniHipatternsHack" },
    todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
    note = { pattern = "NOTE", group = "MiniHipatternsNote" },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
}
