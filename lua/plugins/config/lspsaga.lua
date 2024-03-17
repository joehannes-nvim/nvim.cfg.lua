-- [nfnl] Compiled from fnl/plugins/config/lspsaga.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
local saga = require("lspsaga")
config.setup = function()
  return saga.setup({finder_action_keys = {open = "o", quit = "q", scroll_down = "<C-f>", scroll_up = "<C-b>", split = "i", vsplit = "s"}, max_preview_lines = 21})
end
return config
