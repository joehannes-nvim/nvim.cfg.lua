-- [nfnl] Compiled from fnl/utils/astro/status/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local env = require("utils.astro.status.env")
local utils = require("utils.astro")
local extend_tbl = utils.extend_tbl
local get_icon = utils.get_icon
M.build_provider = function(opts, provider, _)
  return ((opts and {condition = opts.condition, hl = opts.hl, on_click = opts.on_click, opts = opts, provider = provider, update = opts.update}) or false)
end
M.setup_providers = function(opts, providers, setup)
  setup = (setup or M.build_provider)
  for i, provider in ipairs(providers) do
    opts[i] = setup(opts[provider], provider, i)
  end
  return opts
end
M.width = function(is_winbar)
  return ((((vim.o.laststatus == 3) and not is_winbar) and vim.o.columns) or vim.api.nvim_win_get_width(0))
end
M.pad_string = function(str, padding)
  padding = (padding or {})
  return (((str and (str ~= "")) and (string.rep(" ", (padding.left or 0)) .. str .. string.rep(" ", (padding.right or 0)))) or "")
end
local function escape(str)
  return str:gsub("%%", "%%%%")
end
M.stylize = function(str, opts)
  opts = extend_tbl({escape = true, icon = {kind = "NONE", padding = {left = 0, right = 0}}, padding = {left = 0, right = 0}, separator = {left = "", right = ""}, show_empty = false}, opts)
  local icon = M.pad_string(get_icon(opts.icon.kind), opts.icon.padding)
  return (((str and ((str ~= "") or opts.show_empty)) and (opts.separator.left .. M.pad_string((icon .. ((opts.escape and escape(str)) or str)), opts.padding) .. opts.separator.right)) or "")
end
M.surround = function(separator, color, component, condition)
  local function surround_color(self)
    local colors = (((type(color) == "function") and color(self)) or color)
    return (((type(colors) == "string") and {main = colors}) or colors)
  end
  separator = (((type(separator) == "string") and env.separators[separator]) or separator)
  local surrounded = {condition = condition}
  if (separator[1] ~= "") then
    local function _1_(self)
      local s_color = surround_color(self)
      if s_color then
        return {bg = s_color.left, fg = s_color.main}
      else
        return nil
      end
    end
    table.insert(surrounded, {hl = _1_, provider = separator[1]})
  else
  end
  local function _4_(self)
    local s_color = surround_color(self)
    if s_color then
      return {bg = s_color.main}
    else
      return nil
    end
  end
  table.insert(surrounded, {extend_tbl(component, {}), hl = _4_})
  if (separator[2] ~= "") then
    local function _6_(self)
      local s_color = surround_color(self)
      if s_color then
        return {bg = s_color.right, fg = s_color.main}
      else
        return nil
      end
    end
    table.insert(surrounded, {hl = _6_, provider = separator[2]})
  else
  end
  return surrounded
end
M.encode_pos = function(line, col, winnr)
  return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
end
M.decode_pos = function(c)
  return bit.rshift(c, 16), bit.band(bit.rshift(c, 6), 1023), bit.band(c, 63)
end
M.null_ls_providers = function(filetype)
  local registered = {}
  local sources_avail, sources = pcall(require, "null-ls.sources")
  if sources_avail then
    for _, source in ipairs(sources.get_available(filetype)) do
      for method in pairs(source.methods) do
        registered[method] = (registered[method] or {})
        table.insert(registered[method], source.name)
      end
    end
  else
  end
  return registered
end
M.null_ls_sources = function(filetype, method)
  local methods_avail, methods = pcall(require, "null-ls.methods")
  return ((methods_avail and M.null_ls_providers(filetype)[methods.internal[method]]) or {})
end
M.statuscolumn_clickargs = function(self, minwid, clicks, button, mods)
  local args = {button = button, clicks = clicks, minwid = minwid, mods = mods, mousepos = vim.fn.getmousepos()}
  if not self.signs then
    self.signs = {}
  else
  end
  args.char = vim.fn.screenstring(args.mousepos.screenrow, args.mousepos.screencol)
  if (args.char == " ") then
    args.char = vim.fn.screenstring(args.mousepos.screenrow, (args.mousepos.screencol - 1))
  else
  end
  args.sign = self.signs[args.char]
  if not args.sign then
    for _, sign_def in ipairs(vim.fn.sign_getdefined()) do
      if sign_def.text then
        self.signs[(sign_def.text):gsub("%s", "")] = sign_def
      else
      end
    end
    args.sign = self.signs[args.char]
  else
  end
  vim.api.nvim_set_current_win(args.mousepos.winid)
  vim.api.nvim_win_set_cursor(0, {args.mousepos.line, 0})
  return args
end
return M
