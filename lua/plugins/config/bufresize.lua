-- [nfnl] Compiled from fnl/plugins/config/bufresize.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  local opts = {noremap = true, silent = true}
  return (require("bufresize")).setup({register = {keys = {{"n", "<leader>w<", "30<C-w><", opts}, {"n", "<leader>w>", "30<C-w>>", opts}, {"n", "<leader>w+", "10<C-w>+", opts}, {"n", "<leader>w-", "10<C-w>-", opts}, {"n", "<leader>w_", "<C-w>_", opts}, {"n", "<leader>w=", "<C-w>=", opts}, {"n", "<leader>w|", "<C-w>|", opts}, {"n", "<leader>wo", "<C-w>|<C-w>_", opts}}, trigger_events = {"BufWinEnter", "WinEnter"}}, resize = {keys = {}, trigger_events = {"VimResized"}}})
end
return M
