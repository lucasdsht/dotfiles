-- classic stuff

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
vim.keymap.set("n", "<leader>gP", ":!git push origin (__git.current_branch) --set-upstream <CR>")
vim.keymap.set("n", "<leader>gl", ":Git pull<CR>")
vim.keymap.set("n", "<leader>gb", ":Git branch")
vim.keymap.set("n", "<leader>gco", ":Git checkout")

-- rebase stuff

vim.keymap.set("n", "<leader>gj", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "<leader>gk", "<cmd>diffget //3<CR>")

