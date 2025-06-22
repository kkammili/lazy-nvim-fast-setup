return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "eslint-lsp" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local auto_format = vim.g.autoformat ~= false

      opts.servers = opts.servers or {}
      opts.servers.eslint = {
        settings = {
          workingDirectories = { mode = "auto" },
          format = auto_format,
        },
      }

      opts.setup = opts.setup or {}
      opts.setup.eslint = function()
        if not auto_format then
          return
        end

        local function get_client(buf)
          return require("lazyvim.util").lsp.get_clients({ name = "eslint", bufnr = buf })[1]
        end

        local formatter = require("lazyvim.util").lsp.formatter({
          name = "eslint: lsp",
          primary = false,
          priority = 200,
          filter = "eslint",
        })

        -- fallback for Neovim < 0.10.0
        if not pcall(require, "vim.lsp._dynamic") then
          formatter.name = "eslint: EslintFixAll"
          formatter.sources = function(buf)
            local client = get_client(buf)
            return client and { "eslint" } or {}
          end
          formatter.format = function(buf)
            local client = get_client(buf)
            if client then
              local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
              if #diag > 0 then
                vim.cmd("EslintFixAll")
              end
            end
          end
        end

        require("lazyvim.util").format.register(formatter)
      end
    end,
  },
}
