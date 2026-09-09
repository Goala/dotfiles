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

vim.o.winborder = "rounded"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.keymap.set({ "n", "v" }, "Y", '"+y')
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>s", [["hy:%s/\V<C-r>h/<C-r>h/gc<Left><Left><Left>]])
vim.keymap.set("n", "<C-W>t", ":tabe %<CR>")

local function copy_path_with_lines(start_line, end_line)
	local path = vim.fn.expand("%:.")
	if path == "" then
		vim.notify("No file path to copy", vim.log.levels.WARN)
		return
	end

	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	local text
	if start_line == end_line then
		text = string.format("%s:%d", path, start_line)
	else
		text = string.format("%s:%d-%d", path, start_line, end_line)
	end

	vim.fn.setreg("+", text)
	vim.fn.setreg('"', text)
end

vim.keymap.set("n", "<leader>yp", function()
	local line = vim.api.nvim_win_get_cursor(0)[1]
	copy_path_with_lines(line, line)
end, { desc = "Copy relative file path with line number" })

vim.keymap.set("v", "<leader>yp", function()
	local mode = vim.fn.mode()
	local start_line, end_line

	if mode == "v" or mode == "V" or mode == "\22" then
		start_line = vim.fn.line("v")
		end_line = vim.fn.line(".")
	else
		start_line = vim.fn.line("'<")
		end_line = vim.fn.line("'>")
	end

	copy_path_with_lines(start_line, end_line)
end, { desc = "Copy relative file path with line number or range" })

local function set_clipboard(text)
	vim.fn.setreg("+", text)
	vim.fn.setreg('"', text)
end

vim.keymap.set("v", "<leader>ya", function()
	local path = vim.fn.expand("%:.")
	if path == "" then
		vim.notify("No file path to copy", vim.log.levels.WARN)
		return
	end

	local start_pos = vim.fn.getpos("v")
	local end_pos = vim.fn.getpos(".")
	local lines = vim.fn.getregion(start_pos, end_pos, { type = vim.fn.mode() })
	local selection = table.concat(lines, "\n")

	local start_line = math.min(start_pos[2], end_pos[2])
	local end_line = math.max(start_pos[2], end_pos[2])
	local ext = vim.fn.expand("%:e")
	local lang = ext ~= "" and ext or "text"

	set_clipboard(string.format("```%s:%s:%d-%d\n%s\n```", lang, path, start_line, end_line, selection))
end, { desc = "Copy selection as code block for agent" })

vim.keymap.set("n", "<leader>yd", function()
	local path = vim.fn.expand("%")
	if path == "" then
		vim.notify("No file to diff", vim.log.levels.WARN)
		return
	end

	local diff = vim.fn.systemlist({ "git", "diff", "--", path })
	if vim.v.shell_error ~= 0 or #diff == 0 then
		diff = vim.fn.systemlist({ "git", "diff", "--cached", "--", path })
	end

	if #diff == 0 then
		vim.notify("No git diff for this file", vim.log.levels.WARN)
		return
	end

	set_clipboard(table.concat(diff, "\n"))
end, { desc = "Copy git diff for current file" })

vim.keymap.set("n", "<leader>ye", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local diags = vim.diagnostic.get(bufnr)
	if #diags == 0 then
		vim.notify("No diagnostics in buffer", vim.log.levels.WARN)
		return
	end

	local path = vim.fn.expand("%:.")
	local lines = { string.format("# Diagnostics: %s", path) }
	for _, d in ipairs(diags) do
		table.insert(
			lines,
			string.format("%s:%d:%d %s", path, d.lnum + 1, d.col + 1, d.message:gsub("\n", " "))
		)
	end

	set_clipboard(table.concat(lines, "\n"))
end, { desc = "Copy diagnostics for agent" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank({
			higroup = "Visual",
			timeout = 300,
		})
	end,
})

-- stolen from https://medium.com/@jogarcia/delete-items-from-the-quick-fix-list-in-neovim-7fb3280b7ba9
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	desc = "Attach keymaps for quickfix list",
	callback = function()
		vim.keymap.set("n", "dd", function()
			local qf_list = vim.fn.getqflist()

			local current_line_number = vim.fn.line(".")

			if qf_list[current_line_number] then
				table.remove(qf_list, current_line_number)

				vim.fn.setqflist(qf_list, "r")

				local new_line_number = math.min(current_line_number, #qf_list)
				vim.fn.cursor(new_line_number, 1)
			end
		end, {
			buffer = true,
			noremap = true,
			silent = true,
			desc = "Remove quickfix item under cursor",
		})
	end,
})

-- vim.keymap.set("n", "tp", function()
-- 	return "<cmd>" .. vim.v.count .. "t.<cr>"
-- end, { expr = true })
-- vim.keymap.set("n", "rp", function()
-- 	return "<cmd>-" .. vim.v.count .. "t.<cr>"
-- end, { expr = true })
