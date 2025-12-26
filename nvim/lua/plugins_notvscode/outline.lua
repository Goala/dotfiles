return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
		{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
	},
	opts = {
		symbol_folding = {
			autofold_depth = 1,
		},
		outline_window = {
			position = "left",
			width = 10,
		},
	},
}
