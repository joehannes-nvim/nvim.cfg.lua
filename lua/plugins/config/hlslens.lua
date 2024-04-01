-- [nfnl] Compiled from fnl/plugins/config/hlslens.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  do end (require("hlslens")).setup({auto_enable = true, build_position_cb = nil, enable_incsearch = true, float_shadow_blend = 50, nearest_float_when = "auto", override_lens = nil, virt_priority = 100, calm_down = false, nearest_only = false})
  return vim.cmd("    hi default link HlSearchNear IncSearch\n    hi default link HlSearchLens WildMenu\n    hi default link HlSearchLensNear IncSearch\n    hi default link HlSearchFloat IncSearch\n  ")
end
return M
