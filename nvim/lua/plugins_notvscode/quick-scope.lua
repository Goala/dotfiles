return {
	"unblevable/quick-scope",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	config = function()
		vim.cmd.highlight("QuickScopePrimary guifg='#ff9e64' gui=underline ctermfg=155 cterm=underline")
		vim.cmd.highlight("QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")
		vim.cmd([[let g:qs_filetype_blacklist = ['undotree', "neo-tree"] ]])
	end,
}
