return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	config = function()
		require("colorizer").setup({
			css = { rgb_fn = true },
		})
	end,
}
