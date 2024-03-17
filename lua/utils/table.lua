-- [nfnl] Compiled from fnl/utils/table.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.table_has_val = function(tab, val)
  for _, value in ipairs(tab) do
    if (value == val) then
      return true
    else
    end
  end
  return false
end
M.table_has_key = function(tab, idx)
  for index, _ in pairs(tab) do
    if (index == idx) then
      return true
    else
    end
  end
  return false
end
M.table_merge = function(...)
  local args = {...}
  local merged = {}
  if (#args < 2) then
    if (#args == 1) then
      local ___antifnl_rtn_1___ = args[1]
      return ___antifnl_rtn_1___
    else
    end
    local ___antifnl_rtn_1___ = {}
    return ___antifnl_rtn_1___
  else
  end
  for k, v in ipairs(args) do
    if (type(v) == "table") then
      for k2, v2 in pairs(v) do
        merged[k2] = v2
      end
    else
      vim.notify(("table_merge: expected table, got " .. type(v) .. " at index " .. k))
    end
  end
  return merged
end
return M
