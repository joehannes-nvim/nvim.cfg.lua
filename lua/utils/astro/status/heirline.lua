-- [nfnl] Compiled from fnl/utils/astro/status/heirline.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local hl = require("utils.astro.status.hl")
local provider = require("utils.astro.status.provider")
local status_utils = require("utils.astro.status.utils")
local utils = require("utils.astro")
local buffer_utils = require("utils.astro.buffer")
local get_icon = utils.get_icon
M.tab_type = function(self, prefix)
  local tab_type = ""
  if self.is_active then
    tab_type = "_active"
  elseif self.is_visible then
    tab_type = "_visible"
  else
  end
  return ((prefix or "buffer") .. tab_type)
end
local function _2_(component)
  local overflow_hl = hl.get_attributes("buffer_overflow", true)
  local function _3_(self)
    return {left = "tabline_bg", main = (M.tab_type(self) .. "_bg"), right = "tabline_bg"}
  end
  local function _4_(self)
    return self._show_picker
  end
  local function _5_(self)
    if not (self.label and self._picker_labels[self.label]) then
      local bufname = provider.filename()(self)
      local label = bufname:sub(1, 1)
      local i = 2
      while ((label ~= " ") and self._picker_labels[label]) do
        if (i > #bufname) then
          break
        else
        end
        label = bufname:sub(i, i)
        i = (i + 1)
      end
      self._picker_labels[label] = self.bufnr
      self.label = label
      return nil
    else
      return nil
    end
  end
  local function _8_(self)
    return provider.str({padding = {left = 1, right = 1}, str = self.label})
  end
  local function _9_(self)
    self.tab_type = M.tab_type(self)
    return nil
  end
  local function _10_(_, minwid)
    return vim.api.nvim_win_set_buf(0, minwid)
  end
  local function _11_(self)
    return self.bufnr
  end
  local function _12_(self)
    return buffer_utils.is_valid(self.bufnr)
  end
  local function _13_()
    return (vim.t.bufs or {})
  end
  return (require("heirline.utils")).make_buflist(status_utils.surround("tab", _3_, {{condition = _4_, hl = hl.get_attributes("buffer_picker"), init = _5_, provider = _8_, update = false}, component, init = _9_, on_click = {callback = _10_, minwid = _11_, name = "heirline_tabline_buffer_callback"}}, _12_), {hl = overflow_hl, provider = (get_icon("ArrowLeft") .. " ")}, {hl = overflow_hl, provider = (get_icon("ArrowRight") .. " ")}, _13_, false)
end
M.make_buflist = _2_
M.make_tablist = function(...)
  return (require("heirline.utils")).make_tablist(...)
end
M.buffer_picker = function(callback)
  local tabline = (require("heirline")).tabline
  local prev_showtabline = (vim.opt.showtabline):get()
  if (prev_showtabline ~= 2) then
    vim.opt.showtabline = 2
  else
  end
  vim.cmd.redrawtabline()
  local buflist = ((tabline and tabline._buflist) and tabline._buflist[1])
  if buflist then
    buflist._picker_labels = {}
    buflist._show_picker = true
    vim.cmd.redrawtabline()
    local char = vim.fn.getcharstr()
    local bufnr = buflist._picker_labels[char]
    if bufnr then
      callback(bufnr)
    else
    end
    buflist._show_picker = false
  else
  end
  if (prev_showtabline ~= 2) then
    vim.opt.showtabline = prev_showtabline
  else
  end
  return vim.cmd.redrawtabline()
end
return M
