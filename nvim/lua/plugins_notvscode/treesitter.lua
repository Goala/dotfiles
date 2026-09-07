return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- https://neovim.io/doc/user/fold.html#fold-commands
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt.foldcolumn = "0"
			vim.opt.foldtext = ""
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldnestmax = 4
		end,
	},
	-- {
	--   "nvim-treesitter/nvim-treesitter-context",
	--   config = function()
	--     vim.cmd.highlight("TreesitterContextLineNumberBottom gui=underline guisp=Gray")
	--   end,
	-- },
}
