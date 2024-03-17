-- [nfnl] Compiled from fnl/plugins/config/tint.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  local tint = require("tint")
  local transforms = require("tint.transforms")
  local function _1_(winid)
    local bufid = vim.api.nvim_win_get_buf(winid)
    local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
    local floating = (vim.api.nvim_win_get_config(winid).relative ~= "")
    return (((buftype == "terminal") or (buftype == "nofile")) or floating)
  end
  return tint.setup({highlight_ignore_patterns = {"WinSeparator", "StatusLine", "StatusLineNC", "WinBar", "Trouble", "Nofile", "nofile", "Outline", "SymbolsOutline", "WinBarNC", "HeirLine"}, saturation = 0.7, tint = ((((vim.opt.background):get() == "light") and 21) or ( - 21)), tint_background_colors = true, transforms = {transforms.saturate(0.7)}, window_ignore_function = _1_})
end
return M
