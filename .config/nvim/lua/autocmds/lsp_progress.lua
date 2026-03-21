---@diagnostic disable: undefined-doc-name, undefined-field
local autocmd = vim.api.nvim_create_autocmd
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" %s"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local text = table.concat(msg, "\n")
    vim.notify(text, vim.log.levels.INFO, {
      title = client.name,
      on_open = function(win)
        local ok, cfg = pcall(vim.api.nvim_win_get_config, win)
        if ok and cfg then
          cfg.focusable = false
          pcall(vim.api.nvim_win_set_config, win, cfg)
        end
      end,
    })
  end,
})
