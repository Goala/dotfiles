if vim.fn.has("nvim-0.11") == 1 then
	return {
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/codecompanion-history.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("codecompanion").setup({
				extensions = {
					history = {
						enabled = true,
						opts = {
							history_file = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
							max_history = 10,
						},
					},
				},
				strategies = {
					chat = {
						adapter = {
							name = "copilot",
							model = "claude-sonnet-4.5",
						},
					},
					inline = {
						adapter = {
							name = "copilot",
							model = "claude-sonnet-4.5",
						},
					},
				},
				display = {
					chat = {
						intro_message = "🧙‍♂️ Lern coden...",
						-- show_settings = true,
						window = {
							border = "rounded",
							width = math.min(0.3, 75 / vim.o.columns),
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Code Companion Chat" })
		end,
	}
else
	return {}
end
