local api = vim.api
local autocmd = vim.api.nvim_create_autocmd

local function check_triggeredChars(triggerChars)
  local cur_line = api.nvim_get_current_line()
  local pos = api.nvim_win_get_cursor(0)[2]
  local prev_char = cur_line:sub(pos - 1, pos - 1)
  local cur_char = cur_line:sub(pos, pos)

  for _, char in ipairs(triggerChars) do
    if cur_char == char or prev_char == char then
      return true
    end
  end
end

local setup = function(client, bufnr)
  local group = api.nvim_create_augroup("LspSignature", { clear = false })
  api.nvim_clear_autocmds { group = group, buffer = bufnr }

  local triggerChars = client.server_capabilities.signatureHelpProvider.triggerCharacters

  api.nvim_create_autocmd("TextChangedI", {
    group = group,
    buffer = bufnr,
    callback = function()
      if check_triggeredChars(triggerChars) then
        vim.lsp.buf.signature_help { focus = false, silent = true, max_height = 7, border = "single" }
      end
    end,
  })
end

autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client then
        local signatureProvider = client.server_capabilities.signatureHelpProvider
        if signatureProvider and signatureProvider.triggerCharacters then
          setup(client, args.buf)
        end
      end
    end)
  end,
})
