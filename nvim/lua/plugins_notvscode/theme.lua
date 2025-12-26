return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			on_colors = function(colors)
				-- colors.border = "#64C5FF"
				-- colors.border = "#00619b"
				colors.border = "#565f89"
			end,
		})
		vim.cmd.colorscheme("tokyonight-night")
	end,
}
