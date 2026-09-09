return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function(_, opts)
		require("mason-tool-installer").setup(opts)
		require("mason-tool-installer").run_on_start()
	end,
	opts = {
		ensure_installed = {
			"stylua",
			"prettier",
			"eslint_d",
			"oxlint",
		},
	},
}
