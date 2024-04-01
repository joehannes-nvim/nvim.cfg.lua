-- [nfnl] Compiled from fnl/utils/aucmd.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.onAfterBoot = function(opts)
  my.ui.tint()
  return my.ui.updateHighlights()
end
M.onColorScheme = function()
  my.ui.updateHighlights()
  my.ui.tint()
  vim.cmd("set cursorline")
  return vim.cmd("set cursorcolumn")
end
M.onModeChanged = function()
  my.ui.updateHighlights()
  return my.ui.tint()
end
M.grepAndOpen = function()
  local function _1_(pattern)
    if (pattern ~= nil) then
      vim.cmd(("silent grep! " .. pattern))
      return vim.cmd("Trouble quickfix")
    else
      return nil
    end
  end
  return vim.ui.input({prompt = "Enter pattern: "}, _1_)
end
M.toggle_bg_mode = function(force)
  local current = (vim.opt.background):get()
  local other = (((current == "light") and "dark") or "light")
  vim.api.nvim_set_option("background", ((force and current) or other))
  my.ui.updateHighlights()
  return my.ui.tint()
end
M.applyWinSeparatorNCHighlight = function()
  local ns_winsep = vim.api.nvim_create_namespace("CurrentBuffer")
  vim.api.nvim_set_hl_ns(ns_winsep)
  return vim.api.nvim_set_hl(0, "WinSeparator", {bg = "bg", fg = my.color.my.aqua, nocombine = false})
end
M.activate_current_win_sep = function()
  local ns_winsep = vim.api.nvim_create_namespace("CurrentBuffer")
  return vim.api.nvim_set_hl(ns_winsep, "WinSeparator", {bg = my.color.my.magenta, fg = my.color.my.aqua})
end
M.clear_current_win_sep = function()
  local ns_winsep = vim.api.nvim_create_namespace("CurrentBuffer")
  return vim.api.nvim_buf_clear_namespace(0, ns_winsep, 0, ( - 1))
end
return M
