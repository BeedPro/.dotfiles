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
  end, "[Next [C]hange Git")

  map(bufnr, "n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal { "[c", bang = true }
    else
      gitsigns.nav_hunk "prev"
    end
  end, "[Previous [C]hange Git")

  map(bufnr, "n", "<leader>hs", gitsigns.stage_hunk, "[H]unk [S]tage")
  map(bufnr, "n", "<leader>hr", gitsigns.reset_hunk, "[H]unk [R]eset")

  map(bufnr, "v", "<leader>hs", function()
    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, "[H]unk [S]tage (visual)")

  map(bufnr, "v", "<leader>hr", function()
    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, "[H]unk [R]eset (visual)")

  map(bufnr, "n", "<leader>hS", gitsigns.stage_buffer, "[H]unk [S]tage buffer")
  map(bufnr, "n", "<leader>hR", gitsigns.reset_buffer, "[H]unk [R]eset buffer")

  map(bufnr, "n", "<leader>hp", gitsigns.preview_hunk, "[H]unk [P]review")
  map(bufnr, "n", "<leader>hi", gitsigns.preview_hunk_inline, "[H]unk preview [I]nline")

  map(bufnr, "n", "<leader>hb", function()
    gitsigns.blame_line { full = true }
  end, "[H]unk [B]lame line")

  map(bufnr, "n", "<leader>hd", gitsigns.diffthis, "[H]unk [D]iff against index")

  map(bufnr, "n", "<leader>hD", function()
    gitsigns.diffthis "~"
  end, "[H]unk [D]iff against previous commit")

  map(bufnr, "n", "<leader>hQ", function()
    gitsigns.setqflist "all"
  end, "[H]unk [Q]uickfix (all)")

  map(bufnr, "n", "<leader>hq", gitsigns.setqflist, "[H]unk [Q]uickfix")

  map(bufnr, { "o", "x" }, "ih", gitsigns.select_hunk, "[I]nside [H]unk")
end

return M
