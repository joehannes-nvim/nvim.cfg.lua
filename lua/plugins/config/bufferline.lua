-- [nfnl] Compiled from fnl/plugins/config/bufferline.fnl by https://github.com/Olical/nfnl, do not edit.
local my = _G.my
local M = {}
M.setup = function()
  local function highlights()
    local function vimode_color()
      return my.color.my.vimode[vim.fn.mode()]
    end
    local function secondary_vimode_color()
      return my.color.fn.background_blend(vimode_color(), 73)
    end
    local function tertiary_vimode_color()
      return my.color.fn.background_blend(vimode_color(), 50)
    end
    return {background = {bg = tertiary_vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).primary, force = true}, buffer = {bg = tertiary_vimode_color(), fg = my.color.my.dark, force = true}, buffer_selected = {bg = vimode_color(), bold = true, fg = (my.color.theme(my.color.my["current-theme"])).primary, force = true}, buffer_visible = {bg = secondary_vimode_color(), fg = my.color.my.purple, force = true}, close_button = {bg = tertiary_vimode_color(), fg = my.color.my[(vim.opt.background):get()]}, close_button_selected = {bg = vimode_color(), bold = true, fg = (my.color.theme(my.color.my["current-theme"])).primary}, close_button_visible = {bg = secondary_vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).primary}, diagnostic = {bg = tertiary_vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).attention}, diagnostic_selected = {bg = vimode_color(), bold = true, fg = (my.color.theme(my.color.my["current-theme"])).attention, italic = true}, diagnostic_visible = {bg = secondary_vimode_color(), bold = true, fg = (my.color.theme(my.color.my["current-theme"])).attention}, error = {bg = tertiary_vimode_color(), fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).attention, 66)}, error_diagnostic = {bg = tertiary_vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).attention}, error_diagnostic_selected = {bg = vimode_color(), fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).attention, 33)}, error_diagnostic_visible = {bg = secondary_vimode_color(), fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).attention, 21)}, error_selected = {bg = vimode_color(), fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).attention, 66)}, error_visible = {bg = secondary_vimode_color(), fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).attention, 66)}, fill = {bg = (my.color.theme(my.color.my["current-theme"])).primary}, hint = {bg = tertiary_vimode_color(), fg = my.color.util.darken(my.color.my.yellow, 66)}, hint_diagnostic = {bg = tertiary_vimode_color(), fg = my.color.my.yellow}, hint_diagnostic_selected = {bg = vimode_color(), fg = my.color.util.darken(my.color.my.yellow, 33)}, hint_diagnostic_visible = {bg = secondary_vimode_color(), fg = my.color.util.darken(my.color.my.yellow, 21)}, hint_selected = {bg = vimode_color(), fg = my.color.util.darken(my.color.my.yellow, 66)}, hint_visible = {bg = secondary_vimode_color(), fg = my.color.util.darken(my.color.my.yellow, 66)}, info = {bg = tertiary_vimode_color(), fg = my.color.util.darken(my.color.my.blue, 66)}, info_diagnostic = {bg = tertiary_vimode_color(), fg = my.color.my.blue}, info_diagnostic_selected = {bg = vimode_color(), fg = my.color.util.darken(my.color.my.blue, 33)}, info_diagnostic_visible = {bg = secondary_vimode_color(), fg = my.color.util.darken(my.color.my.blue, 21)}, info_selected = {bg = vimode_color(), fg = my.color.util.darken(my.color.my.blue, 66)}, info_visible = {bg = secondary_vimode_color(), fg = my.color.util.darken(my.color.my.blue, 66)}, modified = {bg = tertiary_vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).attention}, modified_selected = {bg = vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).attention}, modified_visible = {bg = secondary_vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).attention}, pick_selected = {bg = my.color.my[(vim.opt.background):get()], fg = vimode_color()}, separator = {bg = tertiary_vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).primary}, separator_selected = {bg = vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).primary}, separator_visible = {bg = secondary_vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).primary}, tab = {bg = tertiary_vimode_color()}, tab_close = {bg = vimode_color(), bold = true, fg = my.color.my.dark}, tab_selected = {bg = vimode_color(), bold = true, fg = my.color.my.light}, warning = {bg = tertiary_vimode_color(), fg = my.color.util.darken(my.color.my.orange, 66)}, warning_diagnostic = {bg = tertiary_vimode_color(), fg = my.color.my.orange}, warning_diagnostic_selected = {bg = vimode_color(), fg = my.color.util.darken(my.color.my.orange, 33)}, warning_diagnostic_visible = {bg = secondary_vimode_color(), fg = my.color.util.darken(my.color.my.orange, 21)}, warning_selected = {bg = vimode_color(), fg = my.color.util.darken(my.color.my.orange, 66)}, warning_visible = {bg = secondary_vimode_color(), fg = my.color.util.darken(my.color.my.orange, 66)}}
  end
  local opts
  local function _1_()
    local function _2_(buf_number)
      if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then
        return true
      else
        return nil
      end
    end
    local function _4_(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = (((e == "error") and "\239\129\151 ") or (((e == "warning") and "\239\129\177 ") or "\239\129\156 "))
        s = (s .. n .. sym)
      end
      return s
    end
    local function _5_(buf)
      return vim.fn.fnamemodify(buf.name, ":t")
    end
    local function _6_(buffer_a, buffer_b)
      local mod_a = (((((vim.loop.fs_stat(buffer_a.path) or {})).atime or {})).sec or 0)
      local mod_b = (((((vim.loop.fs_stat(buffer_b.path) or {})).atime or {})).sec or 0)
      return (mod_a > mod_b)
    end
    return {highlights = highlights(), options = {always_show_bufferline = true, buffer_close_icon = "\239\128\141", close_command = "bp | silent! bd! %d", close_icon = "\239\128\141", custom_areas = {}, custom_filter = _2_, diagnostics = "nvim_lsp", diagnostics_indicator = _4_, indicator = {icon = "\226\150\142", style = "icon"}, left_mouse_command = "buffer %d", left_trunc_marker = "\239\130\168", max_name_length = 21, max_prefix_length = 15, middle_mouse_command = "sbuffer %d", modified_icon = "\226\151\143", name_formatter = _5_, numbers = "none", persist_buffer_sort = true, right_mouse_command = "sbuffer %d", right_trunc_marker = "\239\130\169", separator_style = "slope", show_buffer_close_icons = true, show_buffer_icons = true, show_close_icon = true, show_tab_indicators = true, sort_by = _6_, tab_size = 7, enforce_regular_tabs = false}}
  end
  opts = _1_
  return (require("bufferline")).setup(opts())
end
return M
