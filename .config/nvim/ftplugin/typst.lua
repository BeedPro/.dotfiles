local opt_local = vim.opt_local
local map = vim.keymap.set
local fn = vim.fn

opt_local.spell = true
opt_local.spelllang = "en_gb"
opt_local.colorcolumn = "80"

local function in_slipbox_tree()
  local slipbox = "Slipbox"
  local buf_path = vim.api.nvim_buf_get_name(0)
  local buf_dir = fn.fnamemodify(buf_path, ":p:h")
  local parent = fn.fnamemodify(buf_dir, ":t")
  local grandparent = fn.fnamemodify(buf_dir, ":h:t")

  return parent == slipbox or grandparent == slipbox
end

local function notify_no_matches()
  vim.notify("No matching Typst files found", vim.log.levels.INFO)
end

local function open_qflist()
  if fn.getqflist({ size = 0 }).size == 0 then
    notify_no_matches()
    return false
  end
  vim.cmd "copen"
  return true
end

local function search_with_vimgrep(pattern)
  local escaped = fn.escape(pattern, [[/\]])
  local cwd = fn.getcwd()
  vim.cmd("silent vimgrep /" .. escaped .. "/gj " .. cwd .. "/**/*.typ")
  open_qflist()
end

local function search_with_rg(pattern)
  local rg_cmd = {
    "rg",
    "--vimgrep",
    "--glob",
    "*.typ",
    "--fixed-strings",
    "--",
    pattern,
    fn.getcwd(),
  }

  local results = fn.systemlist(rg_cmd)
  if vim.v.shell_error > 1 then
    vim.notify("rg failed", vim.log.levels.ERROR)
    return
  end
  if #results == 0 then
    notify_no_matches()
    return
  end

  fn.setqflist({}, "r", { title = "Typst grep: " .. pattern, lines = results })
  vim.cmd "copen"
end

local function search_slipbox_titles()
  local pattern = '= "'
  if fn.executable "rg" == 1 then
    search_with_rg(pattern)
    return
  end
  search_with_vimgrep(pattern)
end

if in_slipbox_tree() then
  map("n", "<leader>fn", search_slipbox_titles, {
    buffer = true,
    desc = 'Search Typst files for "= "" in cwd',
  })
end
