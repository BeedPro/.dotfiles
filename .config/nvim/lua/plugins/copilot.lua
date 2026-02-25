return {
  "github/copilot.vim",
  event = "InsertEnter",
  init = function()
    vim.g.copilot_no_maps = true
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_hide_during_completion = true
  end,
}
