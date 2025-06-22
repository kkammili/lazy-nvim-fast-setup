-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Wait for plugins to load
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    -- First ensure LSP config is available
    local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_ok then
      vim.notify("lspconfig not available!")
      return
    end

    -- Then set up TSServer
    if lspconfig.tsserver and lspconfig.tsserver.setup then
      lspconfig.tsserver.setup({})
    else
      vim.notify("tsserver setup not available!")
    end

    -- Set up nvim-cmp
    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok then
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
        },
      })
    end
  end,
})
