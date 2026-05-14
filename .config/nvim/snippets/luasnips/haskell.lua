local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("haskell", {
  s("hdoc", {
    t "-- | ",
    i(1, "[TODO: description]"),
  }),

  s("hdocm", {
    t {
      "{-|",
      "  ",
    },
    i(1, "[TODO: description]"),
    t {
      "",
      "-}",
    },
  }),

  s("hmod", {
    t {
      "{-|",
      "Module      : ",
    },
    i(1, "[TODO: module.name]"),
    t {
      "",
      "Description : ",
    },
    i(2, "[TODO: short description]"),
    t {
      "",
      "Copyright   : ",
    },
    i(3, "[TODO: copyright]"),
    t {
      "",
      "License     : ",
    },
    i(4, "[TODO: license]"),
    t {
      "",
      "Maintainer  : ",
    },
    i(5, "[TODO: maintainer@email.com]"),
    t {
      "",
      "Stability   : ",
    },
    i(6, "[TODO: stability]"),
    t {
      "",
      "Portability : ",
    },
    i(7, "[TODO: portability]"),
    t {
      "",
      "",
    },
    i(8, "[TODO: longer module description]"),
    t {
      "",
      "-}",
    },
  }),

  s("hsec", {
    t "-- * ",
    i(1, "[TODO: section heading]"),
  }),

  s("hsubsec", {
    t "-- ** ",
    i(1, "[TODO: subsection heading]"),
  }),

  s("hchunk", {
    t {
      "-- $",
    },
    i(1, "[TODO: chunkName]"),
    t {
      "",
      "-- ",
    },
    i(2, "[TODO: chunk documentation]"),
  }),

  s("hsince", {
    t "-- @since ",
    i(1, "[TODO: version]"),
  }),

  s("harg", {
    i(1, "[TODO: name]"),
    t " :: ",
    i(2, "[TODO: Type]"),
    t "  -- ^ ",
    i(3, "[TODO: description]"),
  }),

  s("hex", {
    t {
      "-- >>> ",
    },
    i(1, "[TODO: expression]"),
    t {
      "",
      "-- ",
    },
    i(2, "[TODO: result]"),
  }),

  s("hprop", {
    t "-- prop> ",
    i(1, "[TODO: property]"),
  }),

  s("hcode", {
    t {
      "-- @",
      "-- ",
    },
    i(1, "[TODO: code]"),
    t {
      "",
      "-- @",
    },
  }),

  s("hbird", {
    t {
      "-- > ",
    },
    i(1, "[TODO: code]"),
  }),

  s("hlist", {
    t {
      "-- ",
      "-- * ",
    },
    i(1, "[TODO: first item]"),
    t {
      "",
      "-- ",
      "-- * ",
    },
    i(2, "[TODO: second item]"),
  }),

  s("henum", {
    t {
      "-- ",
      "-- (1) ",
    },
    i(1, "[TODO: first item]"),
    t {
      "",
      "-- ",
      "-- 2. ",
    },
    i(2, "[TODO: second item]"),
  }),

  s("hdef", {
    t "-- [@",
    i(1, "[TODO: term]"),
    t "@]: ",
    i(2, "[TODO: definition]"),
  }),

  s("hlink", {
    t "[",
    i(1, "[TODO: link text]"),
    t "](",
    i(2, "[TODO: URL]"),
    t ")",
  }),

  s("himg", {
    t "![",
    i(1, "[TODO: image description]"),
    t "](",
    i(2, "[TODO: path/to/image.png]"),
    t ")",
  }),
})
