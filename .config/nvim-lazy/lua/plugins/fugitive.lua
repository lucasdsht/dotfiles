return {
  'tpope/vim-fugitive',
  keys = {
    -- classic stuff
    {"<leader>gs", vim.cmd.Git},
    {"<leader>gp", ":Git push<cr>"},
    {"<leader>gP", ":!git push origin (__git.current_branch) --set-upstream <cr>"},
    {"<leader>gl", ":Git pull<cr>"},
    {"<leader>gb", ":Git branch<cr>"},
    {"<leader>gco", ":Git checkout<cr>"},
    
    -- rebase related
    {'<leader>gj', "<cmd>diffget //2<cr>"},
    {'<leader>gk', "<cmd>diffget //3<cr>"},

  }
}
