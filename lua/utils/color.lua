-- [nfnl] Compiled from fnl/utils/color.fnl by https://github.com/Olical/nfnl, do not edit.
local M
local function _1_(...)
  return (require("lush.vivid.rgb.convert")).hex_to_rgb(...)
end
local function _2_(color)
  return (require("lush")).hsl(color)
end
local function _3_(color)
  return (require("lush")).hsluv(color)
end
local function _4_(color)
  return ("#" .. string.format("%06x", color))
end
local function _5_(...)
  return (require("lush.vivid.rgb.convert")).rgb_to_hex(...)
end
M = {fn = {}, hex_to_rgb = _1_, hsl = _2_, hsluv = _3_, int_to_hex = _4_, my = {aqua = "#00DFFF", blue = "#0000FF", dark = "#100710", green = "#00FF80", light = "#F0FFFD", magenta = "#F634B1", orange = "#FFAF00", purple = "#A000FF", red = "#FF0080", yellow = "#FFDF00", theme = {["bold-retro"] = {primary = "#F7DE81", secondary = "#595959", normal = "#00FFEF", attention = "#C71585", command = "#800080", flow = "#00FA9A"}}}, rgb_to_hex = _5_}
M.my.vimode = {["\19"] = M.my.theme["bold-retro"].primary, ["\22"] = M.my.theme["bold-retro"].primary, ["!"] = M.my.theme["bold-retro"].command, R = M.my.theme["bold-retro"].attention, Rv = M.my.theme["bold-retro"].attention, S = M.my.theme["bold-retro"].attention, V = M.my.theme["bold-retro"].primary, c = M.my.theme["bold-retro"].command, ce = M.my.theme["bold-retro"].command, cv = M.my.theme["bold-retro"].command, i = M.my.theme["bold-retro"].flow, ic = M.my.theme["bold-retro"].flow, n = M.my.theme["bold-retro"].secondary, no = M.my.theme["bold-retro"].command, r = M.my.theme["bold-retro"].attention, ["r?"] = M.my.theme["bold-retro"].attention, rm = M.my.theme["bold-retro"].attention, s = M.my.theme["bold-retro"].attention, t = M.my.theme["bold-retro"].command, v = M.my.theme["bold-retro"].primary}
M.fn.background_blend = function(color, strength, hl)
  __fnl_global__Bg_2dcolor = nil
  local status, hl_cfg = nil, nil
  local function _6_()
    return vim.api.nvim_get_hl_by_name(hl, true)
  end
  status, hl_cfg = pcall(_6_)
  if (hl and status) then
    __fnl_global__Bg_2dcolor = (hl_cfg.background or (vim.api.nvim_get_hl_by_name("NormalNC", true)).background)
  else
    __fnl_global__Bg_2dcolor = (vim.api.nvim_get_hl_by_name("Normal", true)).background
  end
  local blend_color = M.hsl(color)
  local base_color = ((__fnl_global__Bg_2dcolor and M.int_to_hex(__fnl_global__Bg_2dcolor)) or my.color.my[(vim.opt.background):get()])
  return M.hsl(base_color).mix(blend_color, strength).hex
end
M.fn.highlight_blend_bg = function(hl_name, strength, color, base_hl)
  base_hl = (base_hl or "MyNormal")
  local old_hl = nil
  local function fetch_old_hl()
    if (color == nil) then
      local _old_hl = vim.api.nvim_get_hl_by_name(base_hl, true)
      local target_old_hl = vim.api.nvim_get_hl_by_name(hl_name, true)
      old_hl = ((_old_hl and _old_hl.background) or (target_old_hl and target_old_hl.background))
      return nil
    else
      return nil
    end
  end
  if (pcall(fetch_old_hl) or color) then
    local hl_guibg = M.fn.background_blend(((color or (old_hl and M.int_to_hex(old_hl))) or my.color.my[(vim.opt.background):get()]), strength, "MyNormal")
    return vim.api.nvim_set_hl(0, hl_name, {background = hl_guibg, force = true, nocombine = false})
  else
    return nil
  end
end
M.fn.transparentizeColor = function()
  return string.format("%x", math.floor((255 * (vim.g.transparency or 0.8))))
end
local function _10_(hex_color, percentage)
  return M.hsl(hex_color).darken(percentage).hex
end
local function _11_(hex_color, percentage)
  return M.hsl(hex_color).desaturate(percentage).hex
end
local function _12_(hex_color, percentage)
  return M.hsl(hex_color).lighten(percentage).hex
end
local function _13_(hex_color, percentage)
  return M.hsl(hex_color).saturate(percentage).hex
end
M.util = {darken = _10_, desaturate = _11_, lighten = _12_, saturate = _13_}
return M
