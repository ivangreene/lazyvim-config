return {
  {
    "https://github.com/cholley6/vim-jb",
    commit = "e795ce3a012cb7e63b09af9cce8354c9b4048256",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.jb_style = "dark"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "slate",
    },
  },
}
