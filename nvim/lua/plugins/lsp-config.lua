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
			local border = "rounded"

			vim.diagnostic.config({
				virtual_text = true,
				float = { border = border },
				current_line = true,
				-- virtual_lines = true,
			})

			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"jsonls",
					"bashls",
				},
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

			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover({ border = border })
			end, { desc = "LSP hover" })
			vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "LSP definitions" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP declaration" })
			vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "LSP implementations" })
			vim.keymap.set("n", "go", builtin.lsp_type_definitions, { desc = "LSP type definitions" })
			vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "LSP references" })
			vim.keymap.set("n", "gs", function()
				vim.lsp.buf.signature_help({ border = border })
			end, { desc = "LSP signature help" })
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics" })
			vim.keymap.set("n", "gal", builtin.diagnostics, { desc = "List diagnostics" })

			-- Move to the previous diagnostic
			-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})

			-- Move to the next diagnostic
			-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
		end,
	},
}
