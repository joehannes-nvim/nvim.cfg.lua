-- [nfnl] Compiled from fnl/colorschemes/neon.fnl by https://github.com/Olical/nfnl, do not edit.
local opts = {neon_bold = true, neon_italic_functions = true, neon_italic_keyword = true, neon_italic_variable = true, neon_style = "dark", neon_transparent = false}
for key, value in pairs(opts) do
  vim.api.nvim_set_var(key, value)
end
return nil
