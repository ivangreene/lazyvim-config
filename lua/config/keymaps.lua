-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "x" }, "''", '"+', { desc = "Use system clipboard" })
vim.keymap.set({ "n" }, "-", ":Neotree<cr>", { desc = "Open tree", silent = true })
vim.api.nvim_set_keymap("n", "<leader>yf", [[:let @+=expand('%:.')<CR>]], { desc = "Copy relative file path" })
vim.api.nvim_set_keymap("n", "<leader>yF", [[:let @+=expand('%:p')<CR>]], { desc = "Copy full file path" })
