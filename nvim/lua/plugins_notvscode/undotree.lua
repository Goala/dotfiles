return {
	"mbbill/undotree",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	config = function()
		vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
	end,
}
