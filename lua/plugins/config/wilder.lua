-- [nfnl] Compiled from fnl/plugins/config/wilder.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local wilder = require("wilder")
wilder.set_option("use_python_remote_plugin", 0)
M.setup = function()
  local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({border = "rounded", empty_message = wilder.popupmenu_empty_message_with_spinner(), highlighter = wilder.basic_highlighter(), left = {" ", wilder.popupmenu_devicons(), wilder.popupmenu_buffer_flags({flags = " a + ", icons = {["+"] = "\239\163\170", a = "\239\156\147", h = "\239\156\163"}})}, mode = "popup", pumblend = 20, right = {" ", wilder.popupmenu_scrollbar()}}))
  local palette_renderer
  local function _1_(ctx)
    vim.opt_local.winbar = nil
    return nil
  end
  palette_renderer = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({border = "double", max_height = "75%", min_height = "25%", pre_hook = _1_, prompt_position = "top", pumblend = 50, reverse = 0}))
  local wildmenu_renderer = wilder.wildmenu_renderer({highlighter = {wilder.pcre2_highlighter(), wilder.basic_highlighter()}, left = {" ", wilder.wildmenu_spinner(), " "}, right = {" ", wilder.wildmenu_index()}, separator = " \194\183 "})
  wilder.setup({modes = {":", "/", "?"}})
  wilder.set_option("pipeline", {wilder.branch(wilder.cmdline_pipeline(), wilder.search_pipeline())})
  return wilder.set_option("renderer", wilder.renderer_mux({["/"] = popupmenu_renderer, [":"] = palette_renderer, substitute = wildmenu_renderer}))
end
return M
