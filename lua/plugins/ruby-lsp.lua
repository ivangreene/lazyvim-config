return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruby_lsp = {
        enabled = true,
        mason = false,
        cmd = { "mise", "exec", "--", "ruby-lsp" },
        root_dir = function(bufnr, on_dir)
          local path = vim.api.nvim_buf_get_name(bufnr)
          local root = path:match("^(.*)/vendor/gems/") or vim.fs.root(bufnr, { "Gemfile" })
          if root then
            on_dir(root)
          end
        end,
        init_options = {
          indexing = {
            includedPatterns = { "vendor/gems/*/{app,config,db}/**/*.rb" },
          },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
        },
      },
      rubocop = {
        enabled = false,
      },
    },
  },
}
