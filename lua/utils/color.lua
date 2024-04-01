-- [nfnl] Compiled from fnl/utils/color.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.theme = function(t)
  local t_21 = (t or M.my["current-theme"])
  return M.my.theme[t_21]
end
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
M = vim.tbl_extend("keep", M, {fn = {}, hex_to_rgb = _1_, hsl = _2_, hsluv = _3_, int_to_hex = _4_, my = {aqua = "#00DFFF", blue = "#0000FF", dark = "#100710", green = "#00FF80", light = "#F0FFFD", magenta = "#F634B1", orange = "#FFAF00", purple = "#A000FF", red = "#FF0080", yellow = "#FFDF00", ["current-theme"] = "lush", theme = {["bold-retro"] = {primary = "#F7DE81", secondary = "#595959", normal = "#00FFEF", attention = "#C71585", command = "#800080", flow = "#00FA9A"}, lush = {primary = "#500050", secondary = "#D7BE51", normal = "#A000FF", attention = "#FF0080", command = "#D7BE81", flow = "#00FF80"}}}, rgb_to_hex = _5_})
M.my.vimode = {["\19"] = (M.theme(M["current-theme"])).normal, ["\22"] = (M.theme(M["current-theme"])).normal, ["!"] = (M.theme(M["current-theme"])).command, R = (M.theme(M["current-theme"])).attention, Rv = (M.theme(M["current-theme"])).attention, S = (M.theme(M["current-theme"])).attention, V = (M.theme(M["current-theme"])).primary, c = (M.theme(M["current-theme"])).command, ce = (M.theme(M["current-theme"])).command, cv = (M.theme(M["current-theme"])).command, i = (M.theme(M["current-theme"])).flow, ic = (M.theme(M["current-theme"])).flow, n = (M.theme(M["current-theme"])).secondary, no = (M.theme(M["current-theme"])).command, r = (M.theme(M["current-theme"])).attention, ["r?"] = (M.theme(M["current-theme"])).attention, rm = (M.theme(M["current-theme"])).attention, s = (M.theme(M["current-theme"])).attention, t = (M.theme(M["current-theme"])).command, v = (M.theme(M["current-theme"])).normal}
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
