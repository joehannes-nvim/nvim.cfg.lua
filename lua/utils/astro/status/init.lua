-- [nfnl] Compiled from fnl/utils/astro/status/init.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local env = require("utils.astro.status.env")
local provider = require("utils.astro.status.provider")
local status_utils = require("utils.astro.status.utils")
local utils = require("utils.astro")
local extend_tbl = utils.extend_tbl
M.breadcrumbs = function(opts)
  opts = extend_tbl({icon = {enabled = true, hl = env.icon_highlights.breadcrumbs}, max_depth = 5, padding = {left = 0, right = 0}, separator = (env.separators.breadcrumbs or " \238\130\177 ")}, opts)
  local function _1_(self)
    local data = ((require("aerial")).get_location(true) or {})
    local children = {}
    if (opts.prefix and not vim.tbl_isempty(data)) then
      table.insert(children, {provider = (((opts.prefix == true) and opts.separator) or opts.prefix)})
    else
    end
    local start_idx = 0
    if (opts.max_depth and (opts.max_depth > 0)) then
      start_idx = (#data - opts.max_depth)
      if (start_idx > 0) then
        table.insert(children, {provider = ((require("utils.astro")).get_icon("Ellipsis") .. opts.separator)})
      else
      end
    else
    end
    for i, d in ipairs(data) do
      if (i > start_idx) then
        local child
        local function _5_(_, minwid)
          local lnum, col, winnr = status_utils.decode_pos(minwid)
          return vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), {lnum, col})
        end
        child = {{provider = string.gsub(d.name, "%%", "%%%%"):gsub("%s*->%s*", "")}, on_click = {callback = _5_, minwid = status_utils.encode_pos(d.lnum, d.col, self.winnr), name = "heirline_breadcrumbs"}}
        if opts.icon.enabled then
          local hl = opts.icon.hl
          if (type(hl) == "function") then
            hl = hl(self)
          else
          end
          local hlgroup = string.format("Aerial%sIcon", d.kind)
          table.insert(child, 1, {hl = (((hl and (vim.fn.hlexists(hlgroup) == 1)) and hlgroup) or nil), provider = string.format("%s ", d.icon)})
        else
        end
        if ((#data > 1) and (i < #data)) then
          table.insert(child, {provider = opts.separator})
        else
        end
        table.insert(children, child)
      else
      end
    end
    if (opts.padding.left > 0) then
      table.insert(children, 1, {provider = status_utils.pad_string(" ", {left = (opts.padding.left - 1)})})
    else
    end
    if (opts.padding.right > 0) then
      table.insert(children, {provider = status_utils.pad_string(" ", {right = (opts.padding.right - 1)})})
    else
    end
    self[1] = self:new(children, 1)
    return nil
  end
  return _1_
end
M.separated_path = function(opts)
  opts = extend_tbl({max_depth = 3, padding = {left = 0, right = 0}, path_func = provider.unique_path(), separator = (env.separators.path or " \238\130\177 "), suffix = true}, opts)
  if (opts.suffix == true) then
    opts.suffix = opts.separator
  else
  end
  local function _13_(self)
    local path = opts.path_func(self)
    if (path == ".") then
      path = ""
    else
    end
    local data = vim.fn.split(path, "/")
    local children = {}
    if (opts.prefix and not vim.tbl_isempty(data)) then
      table.insert(children, {provider = (((opts.prefix == true) and opts.separator) or opts.prefix)})
    else
    end
    local start_idx = 0
    if (opts.max_depth and (opts.max_depth > 0)) then
      start_idx = (#data - opts.max_depth)
      if (start_idx > 0) then
        table.insert(children, {provider = ((require("utils.astro")).get_icon("Ellipsis") .. opts.separator)})
      else
      end
    else
    end
    for i, d in ipairs(data) do
      if (i > start_idx) then
        local child = {{provider = d}}
        local separator = (((i < #data) and opts.separator) or opts.suffix)
        if separator then
          table.insert(child, {provider = separator})
        else
        end
        table.insert(children, child)
      else
      end
    end
    if (opts.padding.left > 0) then
      table.insert(children, 1, {provider = status_utils.pad_string(" ", {left = (opts.padding.left - 1)})})
    else
    end
    if (opts.padding.right > 0) then
      table.insert(children, {provider = status_utils.pad_string(" ", {right = (opts.padding.right - 1)})})
    else
    end
    self[1] = self:new(children, 1)
    return nil
  end
  return _13_
end
M.update_events = function(opts)
  local function _22_(self)
    if not rawget(self, "once") then
      local function clear_cache()
        self._win_cache = nil
        return nil
      end
      for _, event in ipairs(opts) do
        local event_opts = {callback = clear_cache}
        if (type(event) == "table") then
          event_opts.pattern = event.pattern
          event_opts.callback = (event.callback or clear_cache)
          event.pattern = nil
          event.callback = nil
        else
        end
        vim.api.nvim_create_autocmd(event, event_opts)
      end
      self.once = true
      return nil
    else
      return nil
    end
  end
  return _22_
end
return M
