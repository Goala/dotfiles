return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
						-- scrollbar = true,
						-- side_padding = 1,
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					}),
				},
				-- formatting = {
				-- 	format = function(entry, vim_item)
				-- 		-- Kind icons
				-- 		-- local kind_icons = {
				-- 		-- 	Text = "󰉿",
				-- 		-- 	Method = "󰆧",
				-- 		-- 	Function = "󰊕",
				-- 		-- 	Constructor = "",
				-- 		-- 	Field = "󰜢",
				-- 		-- 	Variable = "󰀫",
				-- 		-- 	Class = "󰠱",
				-- 		-- 	Interface = "",
				-- 		-- 	Module = "",
				-- 		-- 	Property = "󰜢",
				-- 		-- 	Unit = "󰑭",
				-- 		-- 	Value = "󰎠",
				-- 		-- 	Enum = "",
				-- 		-- 	Keyword = "󰌋",
				-- 		-- 	Snippet = "",
				-- 		-- 	Color = "󰏘",
				-- 		-- 	File = "󰈙",
				-- 		-- 	Reference = "󰈇",
				-- 		-- 	Folder = "󰉋",
				-- 		-- 	EnumMember = "",
				-- 		-- 	Constant = "󰏿",
				-- 		-- 	Struct = "󰙅",
				-- 		-- 	Event = "",
				-- 		-- 	Operator = "󰆕",
				-- 		-- 	TypeParameter = "",
				-- 		-- }
				-- 		-- Set the icon
				-- 		-- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
				--
				-- 		-- Source
				-- 		vim_item.menu = ({
				-- 			nvim_lsp = "[LSP]",
				-- 			luasnip = "[Snippet]",
				-- 			buffer = "[Buffer]",
				-- 			["render-markdown"] = "[MD]",
				-- 		})[entry.source.name]
				-- 		return vim_item
				-- 	end,
				-- },
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "render-markdown" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
