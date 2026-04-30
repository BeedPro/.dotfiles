local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("LspAttach", {
  group = augroup("LspAttachMappings", { clear = true }),
  callback = function(args)
    require("mappings.lsp").attach(args.buf)
  end,
})
