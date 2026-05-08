local sign = vim.fn.sign_define

sign("DapStopped", { text = "> ", texthl = "SignColumn", linehl = "debugPC" })
