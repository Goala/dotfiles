return {
  "vscode-neovim/vscode-multi-cursor.nvim",
  config = function()
    require("vscode-multi-cursor").setup({
      default_mappings = true,
      no_selection = false,
    })
    vim.keymap.set({ "n", "x", "i" }, "<C-d>", function()
      require("vscode-multi-cursor").addSelectionToNextFindMatch()
    end)
  end,
}
