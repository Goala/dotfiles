return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", version = "^2.*" },
			{ "mason-org/mason-lspconfig.nvim", version = "^2.*" },
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.diagnostic.config({
				virtual_text = true,
				float = { border = "rounded" },
				current_line = true,
				-- virtual_lines = true,
			})

			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = { "lua_ls" },
				handlers = {
					function(server_name)
						vim.lsp.config(server_name, {
							capabilities = capabilities,
						})
						vim.lsp.enable(server_name)
					end,
				},
			})

			local builtin = require("telescope.builtin")

			-- Displays hover information about the symbol under the cursor
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			-- Jump to the definition
			vim.keymap.set("n", "gd", builtin.lsp_definitions, {})

			-- Selects a code action available at the current cursor position
			-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {}) -- → now gra

			-- Jump to declaration
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})

			-- Lists all the implementations for the symbol under the cursor
			vim.keymap.set("n", "gi", builtin.lsp_implementations, {})

			-- Jumps to the definition of the type symbol
			vim.keymap.set("n", "go", builtin.lsp_type_definitions, {})

			-- Lists all the references
			vim.keymap.set("n", "grr", builtin.lsp_references, {})

			-- Displays a function's signature information
			vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, {})

			-- Renames all references to the symbol under the cursor
			-- vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, {}) -- → now grn

			-- Show diagnostics in a floating window
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "gal", builtin.diagnostics, {})

			-- Move to the previous diagnostic
			-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})

			-- Move to the next diagnostic
			-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
		end,
	},
}
