-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "x" }, "''", '"+', { desc = "Use system clipboard" })
vim.keymap.set({ "n" }, "-", ":Neotree<cr>", { desc = "Open tree", silent = true })
vim.api.nvim_set_keymap("n", "<leader>yf", [[:let @+=expand('%:.')<CR>]], { desc = "Copy relative file path" })
vim.api.nvim_set_keymap("n", "<leader>yF", [[:let @+=expand('%:p')<CR>]], { desc = "Copy full file path" })
vim.api.nvim_set_keymap("n", "<leader>yl", [[:let @+=expand('%:.').':'.line('.')<CR>]], { desc = "Copy relative file path with line number" })

-- Always browse the main ref rather than the current branch
vim.keymap.set({ "n", "x" }, "<leader>gB", function()
  Snacks.gitbrowse({ what = "file", branch = "main" })
end, { desc = "Git Browse (main)" })

-- Pick files changed on this branch (vs merge-base with origin/main)
vim.keymap.set("n", "<leader>fG", function()
  local root = vim.fs.root(0, ".git") or vim.uv.cwd()
  local base = vim.fn.systemlist({ "git", "-C", root, "merge-base", "HEAD", "origin/main" })[1]
  if not base or base == "" then
    vim.notify("No merge-base with origin/main", vim.log.levels.WARN)
    return
  end
  Snacks.picker.pick({
    source = "branch_changed",
    title = "Changed on branch",
    cwd = root,
    finder = function()
      local seen, items = {}, {}
      local function add(list)
        for _, f in ipairs(list) do
          if f ~= "" and not seen[f] then
            seen[f] = true
            items[#items + 1] = { text = f, file = f }
          end
        end
      end
      -- committed + uncommitted changes since branch point (exclude deletions)
      add(vim.fn.systemlist({ "git", "-C", root, "diff", "--name-only", "--diff-filter=d", base }))
      -- new untracked files
      add(vim.fn.systemlist({ "git", "-C", root, "ls-files", "--others", "--exclude-standard" }))
      return items
    end,
    format = "file",
  })
end, { desc = "Changed files on branch" })
