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

  vim.api.nvim_set_hl(0, "DiffAdd", { bg = blend(green, bg, 0.16) })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = blend(blue, bg, 0.1) })
  vim.api.nvim_set_hl(0, "DiffText", { bg = blend(blue, bg, 0.3) })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = blend(red, bg, 0.12), fg = blend(red, bg, 0.45) })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("subdue_diff_highlights", { clear = true }),
  callback = subdue_diff_highlights,
})

subdue_diff_highlights()
