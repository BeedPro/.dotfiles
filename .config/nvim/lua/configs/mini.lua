local sessions = require "mini.sessions"
sessions.setup {
  force = { read = false, write = true, delete = true },
}
