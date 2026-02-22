---@private
---@class bigfile
local M = {}

M.meta = {
  desc = "Deal with big files",
  needs_setup = true,
}

---@class bigfile.Config
---@field notify? boolean
local defaults = {
  notify = true, -- show notification when big file detected
  size = 1.5 * 1024 * 1024, -- 1.5MB
  line_length = 1000, -- average line length (useful for minified files)

  ---@param ctx {buf: number, ft: string}
  setup = function(ctx)
    if vim.fn.exists ":NoMatchParen" ~= 0 then
      vim.cmd "NoMatchParen"
    end

    vim.wo.foldmethod = "manual"
    vim.wo.statuscolumn = ""
    vim.wo.conceallevel = 0

    vim.b.completion = false
    vim.b.minianimate_disable = true
    vim.b.minihipatterns_disable = true

    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ctx.buf) then
        vim.bo[ctx.buf].syntax = ctx.ft
      end
    end)
  end,
}

local config = vim.deepcopy(defaults)

---@param opts? bigfile.Config
function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  vim.filetype.add {
    pattern = {
      [".*"] = {
        function(path, buf)
          if not path or not buf or vim.bo[buf].filetype == "bigfile" then
            return
          end

          if path ~= vim.fs.normalize(vim.api.nvim_buf_get_name(buf)) then
            return
          end

          local size = vim.fn.getfsize(path)
          if size <= 0 then
            return
          end

          if size > config.size then
            return "bigfile"
          end

          local lines = vim.api.nvim_buf_line_count(buf)
          if lines > 0 and (size - lines) / lines > config.line_length then
            return "bigfile"
          end
        end,
      },
    },
  }

  local group = vim.api.nvim_create_augroup("bigfile", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "bigfile",
    callback = function(ev)
      if vim.b[ev.buf].bigfile_processed then
        return
      end
      vim.b[ev.buf].bigfile_processed = true
      if config.notify then
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ":p:~:.")

        vim.notify(
          ("Big file detected: %s\nSome features have been disabled."):format(path),
          vim.log.levels.WARN,
          { title = "Big File" }
        )
      end

      vim.api.nvim_buf_call(ev.buf, function()
        config.setup {
          buf = ev.buf,
          ft = vim.filetype.match { buf = ev.buf } or "",
        }
      end)
    end,
  })
end

return M
