return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<m-h>", ":TmuxNavigateLeft<cr>", silent = true },
    { "<m-j>", ":TmuxNavigateDown<cr>", silent = true },
    { "<m-k>", ":TmuxNavigateUp<cr>", silent = true },
    { "<m-l>", ":TmuxNavigateRight<cr>", silent = true },
    { "<m-\\>", ":TmuxNavigatePrevious<cr>", silent = true },
  },
}
