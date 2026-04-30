local map = vim.keymap.set

map("n", "<leader>fa", "<cmd>FzfLua files<CR>", { desc = "[F]ind [A]ll Files" })
map("n", "<leader>ff", "<cmd>FzfLua files hidden=false<CR>", { desc = "[F]ind [F]iles" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "[F]ind [W]ords" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "[F]ind [B]uffers" })
map("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "[F]ind [H]elp" })
map("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "[F]ind [K]eymaps" })
map("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "[F]ind [M]arks" })
map("n", "<leader>fz", "<cmd>FzfLua blines<CR>", { desc = "[F]ind Fu[Z]zy Buffer" })
