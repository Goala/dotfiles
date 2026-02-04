return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs") -- import nvim-autopairs

			autopairs.setup({
				check_ts = true, -- treesitter enabled
				disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
				fast_wrap = {},
			})
			-- import nvim-autopairs completion functionality
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			-- import nvim-cmp plugin (completions plugin)
			local cmp = require("cmp")
			-- make autopairs and completion work together
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = true,
				},
			})
		end,
	},
}
