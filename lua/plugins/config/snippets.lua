-- [nfnl] Compiled from fnl/plugins/config/snippets.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return vim.loop.os_uname().sysname
end
require("snippets")["snippets"] = {_global = {todo = "TODO: ", uname = _1_}}
return nil
