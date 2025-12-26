return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
    local undotree_extension = { sections = { lualine_a = {'filetype'} }, filetypes = {'undotree'} }
		require("lualine").setup({
			options = {
				globalstatus = true,
				theme = "horizon",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_y = {
					{
						"lsp_status",
						icon = "", -- f013
						symbols = {
							-- Standard unicode symbols to cycle through for LSP progress:
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							-- Standard unicode symbol for when LSP is done:
							done = "✓",
							-- Delimiter inserted between LSP names:
							separator = " ",
						},
						-- List of LSP names to ignore (e.g., `null-ls`):
						ignore_lsp = {
							"null-ls",
						},
					},
				},
			},
			extensions = { "trouble", "quickfix", "lazy", "mason", "neo-tree", "symbols-outline", undotree_extension },
		})
	end,
}
