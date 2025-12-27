require "nvchad.mappings"

local nvim_tmux_nav = require "nvim-tmux-navigation"
local snacks = require "snacks"
local dap = require "dap"
local dapui = require "dapui"
local neotest = require "neotest"
local harpoon = require "harpoon"
local builtin = require "telescope.builtin"
local map = vim.keymap.set
local function nomap(mode, lhs)
  pcall(vim.keymap.del, mode, lhs)
end

harpoon:setup()

local function search_filename_no_ext()
  local name = vim.fn.expand "%:t:r"
  if name == "" then
    return
  end
  builtin.live_grep { default_text = "(" .. name .. ")" }
end

nomap("n", "K")
nomap("n", "<leader>x")
nomap("n", "<leader>b")
nomap("n", "<leader>n")
nomap("n", "<leader>e")
nomap("n", "<leader>h")
nomap("n", "<leader>pt")
nomap("n", "<C-n>")
nomap("n", "<tab>")
nomap("n", "<S-tab>")
nomap({ "n", "t" }, "<A-i>")
nomap({ "n", "t" }, "<A-h>")
nomap({ "n", "t" }, "<A-v>")

map("n", "<leader>of", function()
  require("telescope.builtin").find_files {
    cwd = vim.fn.expand "~/Compendium/Agenda",
    prompt_title = "Compendium / Agenda",
  }
end, { desc = "Open Compendium Agenda files" })

map("n", "<leader>a", function()
  harpoon:list():add()
end)
map("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
for i = 1, 5 do
  map("n", "<A-" .. i .. ">", function()
    harpoon:list():select(i)
  end, { desc = "Harpoon select " .. i })
end

map("n", "<space>frb", search_filename_no_ext, { desc = "Search '(filename)' (no ext)" })
map("n", "<leader>oa", "<cmd>Org agenda<CR>", { desc = "Org Agenda" })
map("n", "<leader>oc", "<cmd>Org capture<CR>", { desc = "Org Capture" })

-- Good stuff
map("i", "jk", "<ESC>", { desc = "General Return to Normal mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "General Saves file in all modes" })
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("n", "<leader>rr", ":.lua <cr>", { desc = "Lua Run the current line" })
map("v", "<leader>rr", ":lua <cr>", { desc = "Lua Run the selected lines" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree focus window" })

-- map("n", "Y", "y$", { desc = "Yank to end of line" })
map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "P", '"+p')

-- Oil
map("n", "<leader>.", function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open()
  end
end, { desc = "Toggle Oil file explorer" })

-- Format
map("n", "<leader>cf", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format current buffer" })

-- Snack keybinds
map("n", "<leader>gl", function()
  ---@diagnostic disable-next-line: undefined-field
  snacks.lazygit.log()
end, { desc = "Snacks Lazygit Log (cwd)" })

map("n", "<leader>gf", function()
  ---@diagnostic disable-next-line: undefined-field
  snacks.lazygit.log_file()
end, { desc = "Snacks Lazygit Current File History" })

map("n", "<leader>n", function()
  snacks.notifier.show_history()
end, { desc = "Snacks Notification History" })

map("n", "<leader>un", function()
  snacks.notifier.hide()
end, { desc = "Snacks Dismiss All Notifications" })

-- Tmux Navigations
map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)

map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

map("n", "<leader>K", function()
  vim.diagnostic.open_float(nil, { focus = true, border = "rounded" })
end)

map("n", "K", function()
  vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
end, { desc = "Hover documentation" })

-- Better J behavior
map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Buffer control
map("n", "<leader>bk", "<cmd>bd<CR>", { desc = "Buffer Close buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Buffer Next tabbed buffer" })
map("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Buffer Previous tabbed buffer" })
map("n", "<leader>bl", "<cmd>buffer#<CR>", { desc = "Buffer Previous tabbed buffer" })
map("n", "<tab>", "<cmd>bnext<CR>", { desc = "Buffer Next tabbed buffer" })
map("n", "<S-tab>", "<cmd>bprev<CR>", { desc = "Buffer Previous tabbed buffer" })

-- Center screen when jumping
map("n", "<C-d>", "<C-d>zz", { desc = "General Better page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "General Better page up" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Change to current directory of file
map("n", "<leader>cd", "<cmd> cd %:p:h <CR>", { desc = "General Change to current directory" })

-- LSP
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })
map(
  "n",
  "g?",
  "<cmd> lua vim.diagnostic.open_float(nil, { border = 'rounded',	source = 'always'})<CR>",
  { desc = "LSP Open diagnostics" }
)

map("n", "<leader>lds", "<cmd> Telescope lsp_document_symbols <CR>", { desc = "Telescope List document symbols" })

-- Maps for trouble.nvim
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble Diagnostics" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Trouble Symbols" })
map(
  "n",
  "<leader>cl",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "Trouble LSP Definitions / references / ..." }
)
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble Location List" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble Quickfix List" })

-- DAP
map("n", "<leader>?", function()
  dapui.eval(nil, { enter = true })
end, { desc = "Dap Continue" })
map("n", "<F5>", dap.continue, { desc = "Dap Continue" })
map("n", "<F10>", dap.step_over, { desc = "Dap Step Over" })
map("n", "<F11>", dap.step_into, { desc = "Dap Step Into" })
map("n", "<F12>", dap.step_out, { desc = "Dap Step Out" })
map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Dap Toggle Breakpoint" })
map("n", "<Leader>dB", dap.set_breakpoint, { desc = "Dap Set Breakpoint" })
map("n", "<Leader>dr", dap.repl.open, { desc = "Dap Repl Open" })
map("n", "<Leader>dl", dap.run_last, { desc = "Dap Run Last" })

-- Test runner
map("n", "<leader>tr", neotest.run.run, { desc = "Neotest Run nearest test" })
map("n", "<leader>tc", function()
  neotest.run.run(vim.fn.expand "%")
end, { desc = "Neotest Run current file tests" })
map("n", "<leader>td", function()
  neotest.run.run { strategy = "dap" }
end, { desc = "Neotest Debug the nearest test" })
map("n", "<leader>ts", neotest.run.stop, { desc = "Neotest Stop nearest test" })
map("n", "<leader>ta", neotest.run.attach, { desc = "Neotest Attach to the nearest test" })
