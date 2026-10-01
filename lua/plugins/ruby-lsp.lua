return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruby_lsp = {
        enabled = true,
        mason = false,
        cmd = { "mise", "exec", "--", "ruby-lsp" },
        init_options = {
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
