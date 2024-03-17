-- [nfnl] Compiled from fnl/colorschemes/tokyonight.fnl by https://github.com/Olical/nfnl, do not edit.
local opts = {tokyonight_italic_functions = true, tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer", "symbols_outline", "aerial", "trouble"}, tokyonight_style = "night"}
for key, value in pairs(opts) do
  vim.api.nvim_set_var(key, value)
end
return nil
