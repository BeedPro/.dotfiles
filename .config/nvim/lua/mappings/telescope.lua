local map = vim.keymap.set

map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "[F]ind [A]ll Files" }
)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "[F]ind [W]ords" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "[F]ind [B]uffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "[F]ind [H]elp" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "[M][A]rks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "[F]ind [O]ldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "[F]ind Fu[Z]zy Buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "[C]o[M]mits Git" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "[G]it [S]tatus" })
