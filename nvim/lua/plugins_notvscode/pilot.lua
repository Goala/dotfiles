return {
	"github/copilot.vim",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	config = function()
		vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")
	end,
}
