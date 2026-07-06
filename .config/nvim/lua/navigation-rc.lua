vim.pack.add {
  "https://github.com/ibhagwan/fzf-lua",
}

local function preview_in_source_window(opts)
  local libuv = require("fzf-lua.libuv")
  local shell = require("fzf-lua.shell")

  opts._fzf_cli_args = opts._fzf_cli_args or {}
  opts.fzf_opts = opts.fzf_opts or {}

  local preview = shell.stringify_data(function(selected, _, _)
    local line = selected[1]
    local winid = opts.__CTX and opts.__CTX.winid
    if not line or not winid or not vim.api.nvim_win_is_valid(winid) then
      return
    end

    local path = require("fzf-lua.path")
    local utils = require("fzf-lua.utils")
    local entry = path.entry_to_file(line, opts, opts._uri)
    local file = entry.bufname or entry.path
    if not file then
      return
    end

    if not path.is_absolute(file) then
      file = path.join { opts.cwd or opts._cwd or utils.cwd(), file }
    end

    vim.api.nvim_win_call(winid, function()
      local bufnr = entry.bufnr or vim.fn.bufadd(file)
      if not bufnr or bufnr == 0 then
        return
      end

      vim.fn.bufload(bufnr)
      pcall(vim.api.nvim_win_set_buf, winid, bufnr)
      if entry.line and entry.line > 0 then
        pcall(vim.api.nvim_win_set_cursor, winid, { entry.line, math.max((entry.col or 1) - 1, 0) })
      end
    end)
  end, opts, "{}")

  local restore = shell.stringify_data(function()
    local winid = opts.__CTX and opts.__CTX.winid
    local bufnr = opts.__CTX and opts.__CTX.bufnr
    if not winid or not bufnr or not vim.api.nvim_win_is_valid(winid) or not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end

    pcall(vim.api.nvim_win_set_buf, winid, bufnr)
    if opts.__CTX.cursor then
      pcall(vim.api.nvim_win_set_cursor, winid, opts.__CTX.cursor)
    end
  end, opts, "")

  opts.preview = preview
  opts.fzf_opts["--preview-window"] = "nohidden:right:0"
  table.insert(opts._fzf_cli_args, "--bind=" .. libuv.shellescape("esc:execute-silent(" .. restore .. ")+abort"))

  return opts
end

require("fzf-lua").setup {
  { "telescope", "hide" },
  defaults = {
    file_icons = false,
    git_icons = false,
    color_icons = false,
  },
  fzf_colors = true,
  fzf_opts = {
    ["--layout"] = "reverse",
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  winopts = function()
    local height = math.min(14, math.floor(vim.o.lines * 0.4))
    return {
      split = ("belowright %dnew"):format(height),
      height = height,
      preview = {
        hidden = true,
      },
    }
  end,
  files = {
    cwd_prompt = false,
    previewer = false,
    enrich = preview_in_source_window,
  },
  oldfiles = {
    cwd_only = true,
    previewer = false,
    enrich = preview_in_source_window,
  },
  keymaps = {
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:60%",
      },
    },
  },
}

vim.keymap.set("n", "<leader>fa", "<cmd>FzfLua files<CR>", { desc = "Find all files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Find recent files in current directory" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files hidden=false<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "Find in project" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "Find help tags" })
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "Find keymaps" })
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "Find marks" })
vim.keymap.set("n", "<leader>fz", "<cmd>FzfLua blines<CR>", { desc = "Search current buffer" })
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttachMappings", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "grr", function()
      require("fzf-lua").lsp_references()
    end, { buffer = args.buf, desc = "LSP: find references" })
    vim.keymap.set("n", "gri", function()
      require("fzf-lua").lsp_implementations()
    end, { buffer = args.buf, desc = "LSP: find implementations" })
    vim.keymap.set("n", "grt", function()
      require("fzf-lua").lsp_typedefs()
    end, { buffer = args.buf, desc = "LSP: type definitions" })
    vim.keymap.set("n", "gO", function()
      require("fzf-lua").lsp_document_symbols()
    end, { buffer = args.buf, desc = "LSP: document symbols" })
    vim.keymap.set("n", "gd", function()
      require("fzf-lua").lsp_definitions()
    end, { buffer = args.buf, desc = "Go to definition" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("OilFzfLocalFiles", { clear = true }),
  pattern = "oil",
  callback = function(args)
    vim.keymap.set("n", "<leader>ff", function()
      require("fzf-lua").files { cwd = require("oil").get_current_dir() or vim.fn.getcwd() }
    end, { buffer = args.buf, desc = "Find files in the current directory" })
  end,
})
