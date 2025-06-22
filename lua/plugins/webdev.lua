return {
  -- Treesitter configurations
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   config = function()
  --     require("nvim-treesitter.configs").setup({
  --       ensure_installed = {
  --         "javascript",
  --         "typescript",
  --         "html",
  --         "css",
  --         "json",
  --         "lua",
  --         "python",
  --         "bash",
  --         "markdown",
  --       },
  --       highlight = {
  --         enable = true,
  --         additional_vim_regex_highlighting = false,
  --       },
  --     })
  --   end,
  -- },

  -- TypeScript Tools
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "hrsh7th/cmp-nvim-lsp" },
  --   config = function()
  --     -- Your typescript-tools config (line 50) here
  --   end,
  -- },

  -- Formatting
  -- {
  --   "stevearc/conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       javascript = { "prettier" },
  --       typescript = { "prettier" },
  --       html = { "prettier" },
  --       css = { "prettier" },
  --       json = { "prettier" },
  --       lua = { "stylua" },
  --       python = { "black" },
  --     },
  --   },
  -- },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
    },
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome" },
      })
    end,
  },
}
