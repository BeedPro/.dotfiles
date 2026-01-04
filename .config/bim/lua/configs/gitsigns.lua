return {

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
    local gitsigns = require "gitsigns"

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        desc = desc,
      })
    end

    map("n", "<leader>hn", function()
      if vim.wo.diff then
        vim.cmd.normal { "]c", bang = true }
      else
        gitsigns.nav_hunk "next"
      end
    end, "[H]unk [N]ext Git")

    map("n", "<leader>hp", function()
      if vim.wo.diff then
        vim.cmd.normal { "[c", bang = true }
      else
        gitsigns.nav_hunk "prev"
      end
    end, "[H]unk [P]revious Git")

    map("n", "<leader>hs", gitsigns.stage_hunk, "[H]unk [S]tage")
    map("n", "<leader>hr", gitsigns.reset_hunk, "[H]unk [R]eset")

    map("v", "<leader>hs", function()
      gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, "[H]unk [S]tage (visual)")

    map("v", "<leader>hr", function()
      gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, "[H]unk [R]eset (visual)")

    map("n", "<leader>hS", gitsigns.stage_buffer, "[H]unk [S]tage buffer")
    map("n", "<leader>hR", gitsigns.reset_buffer, "[H]unk [R]eset buffer")

    map("n", "<leader>hP", gitsigns.preview_hunk, "[H]unk [P]review")
    map("n", "<leader>hi", gitsigns.preview_hunk_inline, "[H]unk preview [I]nline")

    map("n", "<leader>hb", function()
      gitsigns.blame_line { full = true }
    end, "[H]unk [B]lame line")

    map("n", "<leader>hd", gitsigns.diffthis, "[H]unk [D]iff against index")

    map("n", "<leader>hD", function()
      gitsigns.diffthis "~"
    end, "[H]unk [D]iff against previous commit")

    map("n", "<leader>hQ", function()
      gitsigns.setqflist "all"
    end, "[H]unk [Q]uickfix (all)")

    map("n", "<leader>hq", gitsigns.setqflist, "[H]unk [Q]uickfix")

    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "[T]oggle [B]lame")

    map("n", "<leader>tw", gitsigns.toggle_word_diff, "[T]oggle [W]ord diff")

    map({ "o", "x" }, "ih", gitsigns.select_hunk, "[I]nside [H]unk")
  end,
}
