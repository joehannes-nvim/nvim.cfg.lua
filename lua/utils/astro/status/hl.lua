-- [nfnl] Compiled from fnl/utils/astro/status/hl.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local env = require("utils.astro.status.env")
M.lualine_mode = function(mode, fallback)
  if not vim.g.colors_name then
    return fallback
  else
  end
  local lualine_avail, lualine = pcall(require, ("lualine.themes." .. vim.g.colors_name))
  local lualine_opts = (lualine_avail and lualine[mode])
  return (((lualine_opts and (type(lualine_opts.a) == "table")) and lualine_opts.a.bg) or fallback)
end
M.mode = function()
  return {bg = M.mode_bg()}
end
M.mode_bg = function()
  return env.modes[vim.fn.mode()][2]
end
M.filetype_color = function(self)
  local devicons_avail, devicons = pcall(require, "nvim-web-devicons")
  if not devicons_avail then
    local ___antifnl_rtn_1___ = {}
    return ___antifnl_rtn_1___
  else
  end
  local _, color = devicons.get_icon_color(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(((self and self.bufnr) or 0)), ":t"), nil, {default = true})
  return {fg = color}
end
M.get_attributes = function(name, include_bg)
  local hl = (env.attributes[name] or {})
  hl.fg = (name .. "_fg")
  if include_bg then
    hl.bg = (name .. "_bg")
  else
  end
  return hl
end
M.file_icon = function(name)
  local hl_enabled = env.icon_highlights.file_icon[name]
  local function _4_(self)
    if ((hl_enabled == true) or ((type(hl_enabled) == "function") and hl_enabled(self))) then
      return M.filetype_color(self)
    else
      return nil
    end
  end
  return _4_
end
return M
