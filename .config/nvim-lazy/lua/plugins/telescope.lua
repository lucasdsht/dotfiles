return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{"<leader>pf", "<cmd>Telescope find_files<cr>", desc="fuzy finder"},
		{"<leader>ps", function() 
			require('telescope.builtin').grep_string({search = vim.fn.input("  ") })
		end, desc="word search"},
		{"<C-p>", "<cmd>Telescope git_files<cr>", desc="fuzy finder git files"}
	}
}
