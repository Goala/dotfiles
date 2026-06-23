return {
	"rmagatti/auto-session",
	lazy = false,
	config = function(_, opts)
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
		require("auto-session").setup(opts)
	end,
	opts = {
		suppressed_dirs = { "~/" },
	},
}
