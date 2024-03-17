-- [nfnl] Compiled from fnl/plugins/config/scrollbar.fnl by https://github.com/Olical/nfnl, do not edit.
local my = _G.my
local M = {}
M.setup = function()
  return (require("scrollbar")).setup({autocmd = {clear = {"BufWinLeave", "TabLeave", "TermLeave", "WinLeave"}, render = {"BufWinEnter", "TabEnter", "TermEnter", "WinEnter", "CmdwinLeave", "TextChanged", "VimResized", "WinScrolled"}}, excluded_buftypes = {"terminal"}, excluded_filetypes = {"", "prompt", "TelescopePrompt", "-MINIMAP-", "MINIMAP", "minimap"}, handle = {color = my.color.my.vimode[vim.fn.mode()], hide_if_all_visible = true, text = " "}, handlers = {diagnostic = true, search = true}, marks = {Error = {color = "red", priority = 1, text = {"-", "="}}, Hint = {color = "green", priority = 4, text = {"-", "="}}, Info = {color = "blue", priority = 3, text = {"-", "="}}, Misc = {color = "purple", priority = 5, text = {"-", "="}}, Search = {color = "orange", priority = 0, text = {"-", "="}}, Warn = {color = "yellow", priority = 2, text = {"-", "="}}}, show = true})
end
return M
