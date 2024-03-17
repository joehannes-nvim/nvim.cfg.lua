-- [nfnl] Compiled from fnl/utils/astro/buffer.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local utils = require("utils.astro")
M.current_buf, M.last_buf = nil, nil
M.sessions = {autosave = {cwd = true, last = true}, ignore = {buftypes = {}, dirs = {}, filetypes = {"gitcommit", "gitrebase"}}}
M.is_valid = function(bufnr)
  if not bufnr then
    bufnr = 0
  else
  end
  return (vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted)
end
M.is_restorable = function(bufnr)
  if (not M.is_valid(bufnr) or (vim.api.nvim_get_option_value("bufhidden", {buf = bufnr}) ~= "")) then
    return false
  else
  end
  local buftype = vim.api.nvim_get_option_value("buftype", {buf = bufnr})
  if (buftype == "") then
    if not vim.api.nvim_get_option_value("buflisted", {buf = bufnr}) then
      return false
    else
    end
    if (vim.api.nvim_buf_get_name(bufnr) == "") then
      return false
    else
    end
  else
  end
  if (vim.tbl_contains(M.sessions.ignore.filetypes, vim.api.nvim_get_option_value("filetype", {buf = bufnr})) or vim.tbl_contains(M.sessions.ignore.buftypes, vim.api.nvim_get_option_value("buftype", {buf = bufnr}))) then
    return false
  else
  end
  return true
end
M.is_valid_session = function()
  local cwd = vim.fn.getcwd()
  for _, dir in ipairs(M.sessions.ignore.dirs) do
    if (vim.fn.expand(dir) == cwd) then
      return false
    else
    end
  end
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if M.is_restorable(bufnr) then
      return true
    else
    end
  end
  return false
end
M.move = function(n)
  if (n == 0) then
    return 
  else
  end
  local bufs = vim.t.bufs
  for i, bufnr in ipairs(bufs) do
    if (bufnr == vim.api.nvim_get_current_buf()) then
      for _ = 0, ((n % #bufs) - 1) do
        local new_i = (i + 1)
        if (i == #bufs) then
          new_i = 1
          local val = bufs[i]
          table.remove(bufs, i)
          table.insert(bufs, new_i, val)
        else
          local tmp = bufs[i]
          bufs[i] = bufs[new_i]
          bufs[new_i] = tmp
        end
        i = new_i
      end
      break
    else
    end
  end
  vim.t.bufs = bufs
  utils.event("BufsUpdated")
  return vim.cmd.redrawtabline()
end
M.nav = function(n)
  local current = vim.api.nvim_get_current_buf()
  for i, v in ipairs(vim.t.bufs) do
    if (current == v) then
      vim.cmd.b(vim.t.bufs[((((i + n) - 1) % #vim.t.bufs) + 1)])
      break
    else
    end
  end
  return nil
end
M.nav_to = function(tabnr)
  if ((tabnr > #vim.t.bufs) or (tabnr < 1)) then
    return utils.notify(("No tab #%d"):format(tabnr), vim.log.levels.WARN)
  else
    return vim.cmd.b(vim.t.bufs[tabnr])
  end
end
M.prev = function()
  if (vim.fn.bufnr() == M.current_buf) then
    if M.last_buf then
      return vim.cmd.b(M.last_buf)
    else
      return utils.notify("No previous buffer found", vim.log.levels.WARN)
    end
  else
    return utils.notify("Must be in a main editor window to switch the window buffer", vim.log.levels.ERROR)
  end
end
M.close = function(bufnr, force)
  if (not bufnr or (bufnr == 0)) then
    bufnr = vim.api.nvim_get_current_buf()
  else
  end
  if ((utils.is_available("mini.bufremove") and M.is_valid(bufnr)) and (#vim.t.bufs > 1)) then
    if (not force and vim.api.nvim_get_option_value("modified", {buf = bufnr})) then
      local bufname = vim.fn.expand("%")
      local empty = (bufname == "")
      if empty then
        bufname = "Untitled"
      else
      end
      local confirm = vim.fn.confirm(("Save changes to \"%s\"?"):format(bufname), "&Yes\n&No\n&Cancel", 1, "Question")
      if (confirm == 1) then
        if empty then
          return 
        else
        end
        vim.cmd.write()
      elseif (confirm == 2) then
        force = true
      else
        return 
      end
    else
    end
    return (require("mini.bufremove")).delete(bufnr, force)
  else
    local buftype = vim.api.nvim_get_option_value("buftype", {buf = bufnr})
    return vim.cmd(("silent! %s %d"):format((((force or (buftype == "terminal")) and "bdelete!") or "confirm bdelete"), bufnr))
  end
end
M.close_all = function(keep_current, force)
  if (keep_current == nil) then
    keep_current = false
  else
  end
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.t.bufs) do
    if (not keep_current or (bufnr ~= current)) then
      M.close(bufnr, force)
    else
    end
  end
  return nil
end
M.close_left = function(force)
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.t.bufs) do
    if (bufnr == current) then
      break
    else
    end
    M.close(bufnr, force)
  end
  return nil
end
M.close_right = function(force)
  local current = vim.api.nvim_get_current_buf()
  local after_current = false
  for _, bufnr in ipairs(vim.t.bufs) do
    if after_current then
      M.close(bufnr, force)
    else
    end
    if (bufnr == current) then
      after_current = true
    else
    end
  end
  return nil
end
M.sort = function(compare_func, skip_autocmd)
  if (type(compare_func) == "string") then
    compare_func = M.comparator[compare_func]
  else
  end
  if (type(compare_func) == "function") then
    local bufs = vim.t.bufs
    table.sort(bufs, compare_func)
    vim.t.bufs = bufs
    if not skip_autocmd then
      utils.event("BufsUpdated")
    else
    end
    vim.cmd.redrawtabline()
    return true
  else
  end
  return false
end
M.close_tab = function(tabpage)
  if (#vim.api.nvim_list_tabpages() > 1) then
    tabpage = (tabpage or vim.api.nvim_get_current_tabpage())
    do end (vim.t[tabpage])["bufs"] = nil
    utils.event("BufsUpdated")
    return vim.cmd.tabclose(vim.api.nvim_tabpage_get_number(tabpage))
  else
    return nil
  end
end
M.comparator = {}
local fnamemodify = vim.fn.fnamemodify
local function bufinfo(bufnr)
  return vim.fn.getbufinfo(bufnr)[1]
end
local function unique_path(bufnr)
  return ((require("utils.astro.status.provider")).unique_path()({bufnr = bufnr}) .. fnamemodify(bufinfo(bufnr).name, ":t"))
end
M.comparator.bufnr = function(bufnr_a, bufnr_b)
  return (bufnr_a < bufnr_b)
end
M.comparator.extension = function(bufnr_a, bufnr_b)
  return (fnamemodify(bufinfo(bufnr_a).name, ":e") < fnamemodify(bufinfo(bufnr_b).name, ":e"))
end
M.comparator.full_path = function(bufnr_a, bufnr_b)
  return (fnamemodify(bufinfo(bufnr_a).name, ":p") < fnamemodify(bufinfo(bufnr_b).name, ":p"))
end
M.comparator.unique_path = function(bufnr_a, bufnr_b)
  return (unique_path(bufnr_a) < unique_path(bufnr_b))
end
M.comparator.modified = function(bufnr_a, bufnr_b)
  return (bufinfo(bufnr_a).lastused > bufinfo(bufnr_b).lastused)
end
return M
