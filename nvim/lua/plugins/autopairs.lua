return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- config = function()
		-- local autopairs = require("nvim-autopairs") -- import nvim-autopairs

		-- setup autopairs
		-- autopairs.setup({
		-- 	check_ts = true, -- treesitter enabled
		-- })
		-- -- import nvim-autopairs completion functionality
		-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		-- -- import nvim-cmp plugin (completions plugin)
		-- local cmp = require("cmp")
		-- -- make autopairs and completion work together
		-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		-- end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = true,
	},
}
