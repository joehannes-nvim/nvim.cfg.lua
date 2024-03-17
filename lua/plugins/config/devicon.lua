-- [nfnl] Compiled from fnl/plugins/config/devicon.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  return (require("nvim-web-devicons")).setup({default = true})
end
return M
