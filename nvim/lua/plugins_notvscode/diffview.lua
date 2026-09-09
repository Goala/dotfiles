return {
	"sindrets/diffview.nvim",
	event = "VeryLazy",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
	},
	keys = {
		{ "<leader>rd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
	},
	config = function()
		require("diffview").setup({})
	end,
}
