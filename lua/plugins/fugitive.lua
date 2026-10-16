local status_height = 11

local function is_horizontal_split()
  return vim.fn.winnr("j") ~= vim.fn.winnr() or vim.fn.winnr("k") ~= vim.fn.winnr()
end

return {
  "https://tpope.io/vim/fugitive.git",
  cmd = { "Git", "G" },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("fugitive_status_height", { clear = true }),
      pattern = "fugitive",
      callback = function()
        if vim.w.fugitive_status_sized or not is_horizontal_split() then
          return
        end
        vim.w.fugitive_status_sized = true
        vim.cmd("resize " .. status_height)
      end,
    })
  end,
}
