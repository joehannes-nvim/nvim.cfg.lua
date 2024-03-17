-- [nfnl] Compiled from fnl/plugins/config/sniprun.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  return (require("sniprun")).setup({display = {"VirtualTextOk", "VirtualTextErr", "LongTempFloatingWindow"}})
end
return M
