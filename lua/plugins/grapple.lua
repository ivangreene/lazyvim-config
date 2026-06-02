return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = { scope = "git_branch" },
  keys = {
    { "<leader>m", function() require("grapple").toggle() end, desc = "Grapple toggle tag" },
    { "<leader>M", function() require("grapple").toggle_tags() end, desc = "Grapple open tags" },
    { "<leader>n", function() require("grapple").cycle_tags("next") end, desc = "Grapple next tag" },
    { "<leader>p", function() require("grapple").cycle_tags("prev") end, desc = "Grapple prev tag" },
  },
}
