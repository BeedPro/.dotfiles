local M = {}

local function map(bufnr, mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = bufnr,
    desc = desc,
  })
end

function M.on_attach(bufnr, gitsigns)
  map(bufnr, "n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal { "]c", bang = true }
    else
      gitsigns.nav_hunk "next"
    end
  end, "Git: next hunk")

  map(bufnr, "n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal { "[c", bang = true }
    else
      gitsigns.nav_hunk "prev"
    end
  end, "Git: previous hunk")

  map(bufnr, "n", "<leader>hs", gitsigns.stage_hunk, "Git: stage hunk")
  map(bufnr, "n", "<leader>hr", gitsigns.reset_hunk, "Git: reset hunk")

  map(bufnr, "v", "<leader>hs", function()
    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, "Git: stage selected hunk")

  map(bufnr, "v", "<leader>hr", function()
    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, "Git: reset selected hunk")

  map(bufnr, "n", "<leader>hS", gitsigns.stage_buffer, "Git: stage buffer")
  map(bufnr, "n", "<leader>hR", gitsigns.reset_buffer, "Git: reset buffer")

  map(bufnr, "n", "<leader>hp", gitsigns.preview_hunk, "Git: preview hunk")
  map(bufnr, "n", "<leader>hi", gitsigns.preview_hunk_inline, "Git: preview inline hunk")

  map(bufnr, "n", "<leader>hb", function()
    gitsigns.blame_line { full = true }
  end, "Git: blame line")

  map(bufnr, "n", "<leader>hd", gitsigns.diffthis, "Git: diff against index")

  map(bufnr, "n", "<leader>hD", function()
    gitsigns.diffthis "~"
  end, "Git: diff against previous commit")

  map(bufnr, "n", "<leader>hQ", function()
    gitsigns.setqflist "all"
  end, "Git: hunks to quickfix (all)")

  map(bufnr, "n", "<leader>hq", gitsigns.setqflist, "Git: hunks to quickfix")

  map(bufnr, { "o", "x" }, "ih", gitsigns.select_hunk, "Select inside hunk")
end

return M
