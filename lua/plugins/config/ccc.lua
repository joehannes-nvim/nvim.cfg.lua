-- [nfnl] Compiled from fnl/plugins/config/ccc.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  local ccc = require("ccc")
  return ccc.setup({inputs = {ccc.input.rgb, ccc.input.hsl}, save_on_quit = true})
end
return M
