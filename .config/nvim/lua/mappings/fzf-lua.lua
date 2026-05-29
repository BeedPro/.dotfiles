local map = vim.keymap.set

map("n", "<leader>fa", "<cmd>FzfLua files<CR>", { desc = "Find all files" })
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Find recent files in current directory" })
map("n", "<leader>ff", "<cmd>FzfLua files hidden=false<CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "Find in project" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "Find help tags" })
map("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "Find keymaps" })
map("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "Find marks" })
map("n", "<leader>fz", "<cmd>FzfLua blines<CR>", { desc = "Search current buffer" })
