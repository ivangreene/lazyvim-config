-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function blend(top, bottom, alpha)
  local out = 0
  for _, shift in ipairs({ 16, 8, 0 }) do
    local divisor = 2 ^ shift
    local t = math.floor(top / divisor) % 256
    local b = math.floor(bottom / divisor) % 256
    out = out + math.floor(t * alpha + b * (1 - alpha) + 0.5) * divisor
  end
  return string.format("#%06x", math.floor(out))
end

local function subdue_diff_highlights()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local bg = normal.bg or (vim.o.background == "dark" and 0x1e1e1e or 0xffffff)
  local green, red, blue = 0x3fb950, 0xf85149, 0x58a6ff

  vim.api.nvim_set_hl(0, "DiffAdd", { bg = blend(green, bg, 0.2) })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = blend(blue, bg, 0.13) })
  vim.api.nvim_set_hl(0, "DiffText", { bg = blend(blue, bg, 0.38) })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = blend(red, bg, 0.16), fg = blend(red, bg, 0.55) })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("subdue_diff_highlights", { clear = true }),
  callback = subdue_diff_highlights,
})

subdue_diff_highlights()

local function highlight_trailing_whitespace_group()
  vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#f85149", fg = "#ffffff" })
end

local function should_match_trailing_whitespace()
  return vim.bo.buftype == "" and vim.api.nvim_win_get_config(0).relative == ""
end

local function match_trailing_whitespace()
  local match_id = vim.w.trailing_whitespace_match
  local wanted = should_match_trailing_whitespace()
  if match_id and not wanted then
    pcall(vim.fn.matchdelete, match_id)
    vim.w.trailing_whitespace_match = nil
  elseif wanted and not match_id then
    vim.w.trailing_whitespace_match = vim.fn.matchadd("TrailingWhitespace", [[\s\+\%#\@<!$]])
  end
end

local trailing_whitespace_group = vim.api.nvim_create_augroup("trailing_whitespace", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = trailing_whitespace_group,
  callback = highlight_trailing_whitespace_group,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  group = trailing_whitespace_group,
  callback = match_trailing_whitespace,
})

highlight_trailing_whitespace_group()
match_trailing_whitespace()
