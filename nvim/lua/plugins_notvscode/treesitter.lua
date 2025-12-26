return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
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
