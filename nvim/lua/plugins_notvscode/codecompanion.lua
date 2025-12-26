if vim.fn.has("nvim-0.11") == 1 then
  return {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy", -- Lazy-load for efficiency
    opts = {
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "WARN", -- Use WARN for efficiency; set to DEBUG only for troubleshooting
      },
    },
    config = function(_, opts)
      -- Place for further scalable custom setup if needed
      require("codecompanion").setup(opts)
    end,
  }
else
  return {}
end
