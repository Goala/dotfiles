vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set signcolumn=no")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.keymap.set({ "n", "v" }, "Y", '"+y')
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>s", [["hy:%s/\V<C-r>h/<C-r>h/gc<Left><Left><Left>]])
vim.keymap.set("n", "<C-W>t", ":tabe %<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "Visual",
			timeout = 300,
		})
	end,
})

-- vim.keymap.set("n", "tp", function()
-- 	return "<cmd>" .. vim.v.count .. "t.<cr>"
-- end, { expr = true })
-- vim.keymap.set("n", "rp", function()
-- 	return "<cmd>-" .. vim.v.count .. "t.<cr>"
-- end, { expr = true })
