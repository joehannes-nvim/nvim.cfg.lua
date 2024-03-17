-- [nfnl] Compiled from fnl/plugins/config/lightbulb.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
vim.cmd("autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()")
M.setup = function()
  return (require("nvim-lightbulb")).update_lightbulb({float = {text = "\226\152\188", win_opts = {}, enabled = false}, sign = {enabled = true, priority = 20, text = "\226\152\188"}, virtual_text = {enabled = true, text = "\226\152\188"}})
end
return M
