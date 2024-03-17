-- [nfnl] Compiled from fnl/utils/ui.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.qftf = function(info)
  local items = nil
  local ret = {}
  if (info.quickfix == 1) then
    items = (vim.fn.getqflist({id = info.id, items = 0})).items
  else
    items = (vim.fn.getloclist(info.winid, {id = info.id, items = 0})).items
  end
  local limit = 31
  local fname_fmt1, fname_fmt2 = ("%-" .. limit .. "s"), ("\226\128\166%." .. (limit - 1) .. "s")
  local valid_fmt = "%s \226\148\130%5d:%-3d\226\148\130%s %s"
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ""
    local str = nil
    if (e == nil) then
      break
    else
    end
    if (e.valid == 1) then
      if (e.bufnr > 0) then
        fname = vim.fn.bufname(e.bufnr)
        if (fname == "") then
          fname = "[No Name]"
        else
          fname = fname:gsub(("^" .. vim.env.HOME), "~")
        end
        if (#fname <= limit) then
          fname = fname_fmt1:format(fname)
        else
          fname = fname_fmt2:format(fname:sub((1 - limit)))
        end
      else
      end
      local lnum = (((e.lnum > 99999) and ( - 1)) or e.lnum)
      local col = (((e.col > 999) and ( - 1)) or e.col)
      local qtype = (((e.type == "") and "") or (" " .. (e.type):sub(1, 1):upper()))
      str = valid_fmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end
M.tint = function()
  local function vimode_color()
    return my.color.my.vimode[vim.fn.mode()]
  end
  local function secondary_vimode_color()
    return my.color.fn.background_blend(vimode_color(), 70)
  end
  local function tertiary_vimode_color()
    return my.color.fn.background_blend(vimode_color(), 21)
  end
  local ok, tint = pcall(require, "tint")
  local ok_bufferline, _ = pcall(require, "bufferline")
  local bufferline = require("plugins.config.bufferline")
  local lines = require("heirline")
  local heirline = require("plugins.config.heirline")
  tint.refresh()
  if ok then
    heirline.update()
    heirline.setup(false)
  else
  end
  if ok_bufferline then
    bufferline.setup()
    return vim.cmd.redrawtabline()
  else
    return nil
  end
end
M.updateHighlights = function()
  local mode_color = my.color.my.vimode[vim.fn.mode()]
  local function secondary_vimode_color()
    return my.color.fn.background_blend(mode_color, 50)
  end
  local function tertiary_vimode_color()
    return my.color.fn.background_blend(mode_color, 21)
  end
  for def_color, git_signs_hl in pairs({[my.color.my.theme["bold-retro"].flow] = "GitSignsAdd", [my.color.my.theme["bold-retro"].normal] = "GitSignsChange", [my.color.my.theme["bold-retro"].attention] = "GitSignsDelete"}) do
    my.color.fn.highlight_blend_bg((git_signs_hl .. "Nr"), 50, def_color)
    my.color.fn.highlight_blend_bg((git_signs_hl .. "Ln"), 70, def_color)
  end
  my.color.fn.highlight_blend_bg("CursorLine", 73, my.color.my.theme["bold-retro"].primary)
  my.color.fn.highlight_blend_bg("CursorColumn", 73, my.color.my.theme["bold-retro"].primary)
  my.color.fn.highlight_blend_bg("Visual", 37, my.color.my.theme["bold-retro"].primary)
  my.color.fn.highlight_blend_bg("TSCurrentScope", 10, mode_color)
  my.color.fn.highlight_blend_bg("TreesitterContext", 21, mode_color)
  vim.api.nvim_set_hl(0, "TreesitterContextBottom", {fg = my.color.my.theme["bold-retro"].primary, sp = my.color.my.theme["bold-retro"].attention, underdouble = true, underline = true})
  return vim.api.nvim_set_hl(0, "ScrollbarHandle", {bg = mode_color})
end
M.tablinePickBuffer = function()
  local tabline = (require("heirline")).tabline
  local buflist = tabline._buflist[1]
  buflist._picker_labels = {}
  buflist._show_picker = true
  vim.cmd.redrawtabline()
  local char = vim.fn.getcharstr()
  local bufnr = buflist._picker_labels[char]
  if bufnr then
    vim.api.nvim_win_set_buf(0, bufnr)
  else
  end
  buflist._show_picker = false
  return vim.cmd.redrawtabline()
end
M.toggleSidebar = function(which)
  vim.cmd(("SwitchPanelSwitch " .. which))
  return (require("switchpanel.panel_list")).close()
end
_G._G.TERMINAL_CURRENT = nil
_G._G.TERMINAL_LIST = {}
M.cycleTerminal = function(direction)
  if (#_G.TERMINAL_LIST < 2) then
    return 
  else
  end
  local terminal_next = nil
  if direction then
    for _, val in pairs(_G.TERMINAL_LIST) do
      if (val > _G.TERMINAL_CURRENT) then
        terminal_next = val
        break
      else
      end
    end
    if not terminal_next then
      terminal_next = _G.TERMINAL_LIST[0]
    else
    end
  elseif not direction then
    for _, val in pairs(_G.TERMINAL_LIST) do
      if (val >= _G.TERMINAL_CURRENT) then
        break
      else
        terminal_next = val
      end
    end
    if not terminal_next then
      terminal_next = _G.TERMINAL_LIST[#_G.TERMINAL_LIST]
    else
    end
  else
  end
  return vim.cmd((terminal_next .. "ToggleTerm"))
end
M.addTerminal = function(nr)
  local idx = ( - 1)
  local sel_val = nil
  for key, val in pairs(_G.TERMINAL_LIST) do
    if (nr.id <= val) then
      idx = key
      sel_val = val
      break
    else
    end
  end
  if (sel_val == nr.id) then
    return 0
  else
  end
  if (idx == ( - 1)) then
    idx = #_G.TERMINAL_LIST
  else
  end
  table.insert(_G.TERMINAL_LIST, idx, nr.id)
  TERMINAL_CURRENT = nr.id
  return idx
end
M.removeTerminal = function(nr)
  local idx = 0
  for key, val in pairs(_G.TERMINAL_LIST) do
    if (nr.id == val) then
      idx = key
      break
    else
    end
    table.remove(_G.TERMINAL_LIST, idx)
  end
  if (_G.TERMINAL_CURRENT == nr.id) then
    TERMINAL_CURRENT = nil
    return nil
  else
    return nil
  end
end
M.openTerminal = function(nr)
  nr = ((nr or vim.v.count1) or 1)
  return vim.cmd((nr .. "ToggleTerm direction='float'"))
end
M.lineDiagnostics = function()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      return 
    else
    end
  end
  return vim.diagnostic.open_float(0, {close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave"}, scope = "cursor", focusable = false})
end
M["set-cursor-ns"] = function()
  return vim.api.nvim_create_namespace("my_cursor")
end
M["clear-cursor-ns!"] = function()
  do
    local my_ns = vim.api.nvim_get_namespaces().my_cursor
    if not (nil == my_ns) then
      vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces().my_cursor, 1, -1)
    else
    end
  end
  return vim.api.nvim_create_namespace("my_cursor")
end
M["set-cursor-hl"] = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local height = vim.api.nvim_win_get_height(0)
  local my_ns = vim.api.nvim_get_namespaces().my_cursor
  vim.api.nvim_get_hl(my_ns, {name = "MyCursorHL", create = true})
  vim.api.nvim_set_hl(0, "MyCursorHL", {bg = my.color.my.vimode[vim.fn.mode()], force = true})
  vim.highlight.range(0, my_ns, "MyCursorHL", {cursor[1], 1}, {cursor[1], -1}, {priority = 65535})
  vim.api.nvim_buf_add_highlight(0, my_ns, "MyCursorHL", cursor[1], 1, -1)
  for i = 1, height, 1 do
    vim.api.nvim_buf_add_highlight(0, my_ns, "MyCursorHL", i, cursor[2], (1 + cursor[2]))
    vim.highlight.range(0, my_ns, "MyCursorHL", {i, cursor[2]}, {i, (1 + cursor[2])}, {priority = 65535})
  end
  return nil
end
return M
