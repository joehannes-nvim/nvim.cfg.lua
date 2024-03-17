-- [nfnl] Compiled from fnl/plugins/config/auto_session.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  local opts = {auto_restore_enabled = true, auto_save_enabled = true, auto_session_enable_last_session = true, auto_session_enabled = true, auto_session_root_dir = (vim.fn.stdpath("data") .. "/sessions/"), auto_session_suppress_dirs = nil, auto_session_use_git_branch = true, log_level = "error", post_restore_cmds = {}, post_save_cmds = {}, pre_restore_cmds = {}, pre_save_cmds = {}}
  return (require("auto-session")).setup(opts)
end
return M
