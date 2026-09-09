return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local helpers = require("null-ls.helpers")
		local utils = require("null-ls.utils")
		local cmd_resolver = require("null-ls.helpers.command_resolver")

		local has_eslint_config = utils.cosmiconfig("eslint", "eslintConfig")

		local oxlint_patterns = {
			".oxlintrc.json",
			".oxlintrc.jsonc",
			"oxlint.config.js",
			"oxlint.config.ts",
			"oxlint.config.mjs",
			"oxlint.config.cjs",
		}
		local has_oxlint_config = function(bufname)
			return utils.root_pattern(unpack(oxlint_patterns))(bufname) ~= nil
		end

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				require("none-ls.diagnostics.eslint_d").with({
					runtime_condition = function(params)
						return has_eslint_config(params.bufname) ~= nil
					end,
				}),
				require("none-ls.code_actions.eslint_d").with({
					runtime_condition = function(params)
						return has_eslint_config(params.bufname) ~= nil
					end,
				}),
				require("none-ls.diagnostics.oxlint").with({
					dynamic_command = cmd_resolver.from_node_modules(),
					cwd = helpers.cache.by_bufnr(function(params)
						return utils.root_pattern(unpack(oxlint_patterns))(params.bufname)
					end),
					runtime_condition = function(params)
						return has_oxlint_config(params.bufname)
					end,
				}),
			},
		})

		local function should_format(bufnr)
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return false
			end
			if not vim.bo[bufnr].modifiable or vim.bo[bufnr].buftype ~= "" then
				return false
			end
			if vim.bo[bufnr].filetype == "" then
				return false
			end
			return #vim.lsp.get_clients({ bufnr = bufnr, name = "null-ls" }) > 0
		end

		local function format_buf(bufnr)
			bufnr = bufnr or vim.api.nvim_get_current_buf()
			if not should_format(bufnr) then
				return
			end
			vim.lsp.buf.format({
				bufnr = bufnr,
				filter = function(client)
					return client.name == "null-ls"
				end,
			})
			-- Formatting invalidates diagnostic extmarks without always triggering
			-- a new publishDiagnostics from the LSP; re-show cached diagnostics.
			vim.diagnostic.show(nil, bufnr)
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				format_buf(args.buf)
			end,
		})

		vim.keymap.set("n", "<leader>gf", function()
			format_buf()
		end, { desc = "Format buffer" })
	end,
}
