-- [nfnl] Compiled from fnl/settings/init.fnl by https://github.com/Olical/nfnl, do not edit.
local vim_vars = require("settings.variables")
local vim_options = require("settings.options")
local vim_aucmds = require("settings.aucmds")
local vim_settings = require("settings.settings")
for key, value in pairs(vim_vars) do
  vim.api.nvim_set_var(key, value)
end
for key, value in pairs(vim_options) do
  vim.api.nvim_set_option(key, value)
end
do end (vim.opt.listchars):append("eol:\226\134\180")
vim.cmd(vim_settings)
for group_id, group_v in pairs(vim_aucmds) do
  local group = vim.api.nvim_create_augroup(group_id, {clear = true})
  local function aucmd_21(_group, events, pattern, _callback)
    return vim.api.nvim_create_autocmd(events, {callback = _callback, group = group, pattern = pattern})
  end
  for events, cmds in pairs(group_v) do
    if ((cmds.pattern ~= nil) or (cmds.callback ~= nil)) then
      for _, ev in ipairs(events) do
        aucmd_21(group_id, ev, cmds.pattern, cmds.callback)
      end
    else
    end
  end
end
return nil
