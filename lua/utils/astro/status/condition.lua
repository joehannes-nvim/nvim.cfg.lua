-- [nfnl] Compiled from fnl/utils/astro/status/condition.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local env = require("utils.astro.status.env")
M.is_active = function()
  return (vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin))
end
M.buffer_matches = function(patterns, bufnr)
  for kind, pattern_list in pairs(patterns) do
    if env.buf_matchers[kind](pattern_list, bufnr) then
      return true
    else
    end
  end
  return false
end
M.is_macro_recording = function()
  return (vim.fn.reg_recording() ~= "")
end
M.is_hlsearch = function()
  return (vim.v.hlsearch ~= 0)
end
M.is_statusline_showcmd = function()
  return ((vim.fn.has("nvim-0.9") == 1) and ((vim.opt.showcmdloc):get() == "statusline"))
end
M.is_git_repo = function(bufnr)
  if (type(bufnr) == "table") then
    bufnr = bufnr.bufnr
  else
  end
  return ((vim.b[(bufnr or 0)]).gitsigns_head or (vim.b[(bufnr or 0)]).gitsigns_status_dict)
end
M.git_changed = function(bufnr)
  if (type(bufnr) == "table") then
    bufnr = bufnr.bufnr
  else
  end
  local git_status = (vim.b[(bufnr or 0)]).gitsigns_status_dict
  return (git_status and ((((git_status.added or 0) + (git_status.removed or 0)) + (git_status.changed or 0)) > 0))
end
M.file_modified = function(bufnr)
  if (type(bufnr) == "table") then
    bufnr = bufnr.bufnr
  else
  end
  return (vim.bo[(bufnr or 0)]).modified
end
M.file_read_only = function(bufnr)
  if (type(bufnr) == "table") then
    bufnr = bufnr.bufnr
  else
  end
  local buffer = vim.bo[(bufnr or 0)]
  return (not buffer.modifiable or buffer.readonly)
end
M.has_diagnostics = function(bufnr)
  if (type(bufnr) == "table") then
    bufnr = bufnr.bufnr
  else
  end
  return ((vim.g.diagnostics_mode > 0) and (#vim.diagnostic.get((bufnr or 0)) > 0))
end
M.has_filetype = function(bufnr)
  if (type(bufnr) == "table") then
    bufnr = bufnr.bufnr
  else
  end
  return ((vim.bo[(bufnr or 0)]).filetype and ((vim.bo[(bufnr or 0)]).filetype ~= ""))
end
M.aerial_available = function()
  return package.loaded.aerial
end
M.lsp_attached = function(bufnr)
  if (type(bufnr) == "table") then
    bufnr = bufnr.bufnr
  else
  end
  return (package.loaded["utils.astro.lsp"] and (next(vim.lsp.get_active_clients({bufnr = (bufnr or 0)})) ~= nil))
end
M.treesitter_available = function(bufnr)
  if not package.loaded["nvim-treesitter"] then
    return false
  else
  end
  if (type(bufnr) == "table") then
    bufnr = bufnr.bufnr
  else
  end
  local parsers = require("nvim-treesitter.parsers")
  return parsers.has_parser(parsers.get_buf_lang((bufnr or vim.api.nvim_get_current_buf())))
end
M.foldcolumn_enabled = function()
  return ((vim.opt.foldcolumn):get() ~= "0")
end
M.numbercolumn_enabled = function()
  return ((vim.opt.number):get() or (vim.opt.relativenumber):get())
end
M.signcolumn_enabled = function()
  return ((vim.opt.signcolumn):get() ~= "no")
end
return M
