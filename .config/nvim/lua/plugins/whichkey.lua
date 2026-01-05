return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = function(ctx)
      if ctx.plugin == "spelling" then
        return 0
      end
      return 1000
    end,
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "[?] WhichKey",
    },
  },
}
