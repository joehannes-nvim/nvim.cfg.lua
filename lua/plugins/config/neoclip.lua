-- [nfnl] Compiled from fnl/plugins/config/neoclip.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
config.setup = function()
  local function _1_()
    return true
  end
  return (require("neoclip")).setup({continuous_sync = true, db_path = (vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3"), default_register = "\"", default_register_macros = "q", enable_macro_history = true, enable_persistent_history = true, filter = _1_, history = 1000, keys = {fzf = {custom = {}, paste = "ctrl-p", paste_behind = "ctrl-P", select = "default"}, telescope = {i = {custom = {}, delete = "<c-d>", paste = "<c-p>", paste_behind = "<c-P>", replay = "<c-q>", select = "<cr>"}, n = {custom = {}, delete = "d", paste = "p", paste_behind = "P", replay = "q", select = "<cr>"}}}, on_paste = {set_reg = false}, on_replay = {set_reg = false}, preview = true, content_spec_column = false})
end
return config
