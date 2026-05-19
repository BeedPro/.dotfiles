local opt_local = vim.opt_local
local map = vim.keymap.set
local fn = vim.fn

opt_local.spell = true
opt_local.spelllang = "en_gb"
opt_local.colorcolumn = "80"

local function opened_with_flag(flag)
  for _, arg in ipairs(vim.v.argv) do
    if arg == flag then
      return true
    end
  end
  return false
end

if opened_with_flag "-A" then
  opt_local.spell = false
end

local function in_slipbox()
  local buf_path = fn.resolve(vim.api.nvim_buf_get_name(0))
  return buf_path:find(fn.resolve(fn.expand "~/Compendium/Slipbox"), 1, true) ~= nil
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

if in_slipbox() then
  map("n", "<leader>fn", search_slipbox_titles, {
    buffer = true,
    desc = "[F]ind Slipbox [N]otes by Title",
  })
end
