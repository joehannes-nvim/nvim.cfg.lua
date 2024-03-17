-- [nfnl] Compiled from fnl/plugins/config/glow.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  return (require("glow")).setup({height_ratio = 1, width = 120, width_ratio = 1})
end
return M
