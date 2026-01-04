return {
  Lua = {
    runtime = { version = "LuaJIT" },
    diagnostics = {
      globals = { "vim" },
    },
    workspace = {
      library = {
        vim.fn.expand "$VIMRUNTIME/lua",
        vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        "${3rd}/luv/library",
      },
    },
  },
}

