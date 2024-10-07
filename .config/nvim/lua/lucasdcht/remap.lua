vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ff", vim.cmd.Ex)
vim.keymap.set('n', '<C-s>', ":!tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>y", "\"*yy")
vim.keymap.set("v", "<leader>y", "\"*yy")
vim.keymap.set("n", "<leader>Y", "\"*Y")


-- specific key to chmod the current file
vim.keymap.set("n", "<C-x>", ":!chmod +x % ")
