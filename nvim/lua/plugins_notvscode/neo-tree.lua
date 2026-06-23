return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"s1n7ax/nvim-window-picker",
	},
	event = "VeryLazy",
	config = function()
		require("neo-tree").setup({
			window = {
				position = "right",
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					-- hide_gitignored = true,
				},
				follow_current_file = {
					enabled = true,
				},
				window = {
					mappings = {
						["<leader>p"] = "preview_in_explorer",
					},
				},
				commands = {
					preview_in_explorer = function(state)
						local node = state.tree:get_node()
						os.execute("explorer.exe `wslpath -w '" .. node.path .. "'`&")
					end,
				},
			},
		})

		vim.keymap.set("n", "<leader>n", "<cmd>Neotree filesystem reveal right<CR>", { desc = "Neo-tree filesystem" })
		vim.keymap.set("n", "<leader>b", "<cmd>Neotree buffers reveal right<CR>", { desc = "Neo-tree buffers" })
		vim.keymap.set("n", "<leader>gg", "<cmd>Neotree git_status reveal right<CR>", { desc = "Neo-tree git status" })

		require("window-picker").setup({
			show_prompt = false,
			hint = "floating-big-letter",
		})
	end,
}
