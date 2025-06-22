-- ~/.config/nvim/lua/plugins/conform-angular.lua
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "prettier")
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local supported = {
        "html",
        "typescript",
        "javascript",
        "css",
        "scss",
        "json",
        "yaml",
        "markdown",
        "htmlangular", -- if you're using a custom filetype
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        vim.list_extend(opts.formatters_by_ft[ft], { "prettier" })
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
        condition = function(_, ctx)
          local util = require("conform.util")
          return util.root_has_file({ ".prettierrc", ".prettierrc.js", "prettier.config.js" })
        end,
      }
    end,
  },
}
