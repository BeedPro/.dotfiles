vim.pack.add {
  "https://github.com/lewis6991/gitsigns.nvim",
}

require("gitsigns").setup {
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "^" },
    changedelete = { text = "!" },
    untracked = { text = "?" },
  },
  signs_staged = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "^" },
    changedelete = { text = "!" },
    untracked = { text = "?" },
  },
  on_attach = function(bufnr)
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal { "]c", bang = true }
      else
        require("gitsigns").nav_hunk "next"
      end
    end, { buffer = bufnr, desc = "Git: next hunk" })
    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal { "[c", bang = true }
      else
        require("gitsigns").nav_hunk "prev"
      end
    end, { buffer = bufnr, desc = "Git: previous hunk" })
    vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk, { buffer = bufnr, desc = "Git: stage hunk" })
    vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk, { buffer = bufnr, desc = "Git: reset hunk" })
    vim.keymap.set("v", "<leader>hs", function()
      require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { buffer = bufnr, desc = "Git: stage selected hunk" })
    vim.keymap.set("v", "<leader>hr", function()
      require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { buffer = bufnr, desc = "Git: reset selected hunk" })
    vim.keymap.set("n", "<leader>hS", require("gitsigns").stage_buffer, { buffer = bufnr, desc = "Git: stage buffer" })
    vim.keymap.set("n", "<leader>hR", require("gitsigns").reset_buffer, { buffer = bufnr, desc = "Git: reset buffer" })
    vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { buffer = bufnr, desc = "Git: preview hunk" })
    vim.keymap.set("n", "<leader>hi", require("gitsigns").preview_hunk_inline, { buffer = bufnr, desc = "Git: preview inline hunk" })
    vim.keymap.set("n", "<leader>hb", function()
      require("gitsigns").blame_line { full = true }
    end, { buffer = bufnr, desc = "Git: blame line" })
    vim.keymap.set("n", "<leader>hd", require("gitsigns").diffthis, { buffer = bufnr, desc = "Git: diff against index" })
    vim.keymap.set("n", "<leader>hD", function()
      require("gitsigns").diffthis "~"
    end, { buffer = bufnr, desc = "Git: diff against previous commit" })
    vim.keymap.set("n", "<leader>hQ", function()
      require("gitsigns").setqflist "all"
    end, { buffer = bufnr, desc = "Git: hunks to quickfix (all)" })
    vim.keymap.set("n", "<leader>hq", require("gitsigns").setqflist, { buffer = bufnr, desc = "Git: hunks to quickfix" })
    vim.keymap.set({ "o", "x" }, "ih", require("gitsigns").select_hunk, { buffer = bufnr, desc = "Select inside hunk" })
  end,
}
