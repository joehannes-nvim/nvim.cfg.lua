-- [nfnl] Compiled from fnl/utils/tables.fnl by https://github.com/Olical/nfnl, do not edit.
local function deep_copy(x)
  if ("table" == type(x)) then
    local tbl_14_auto = {}
    for k, v in pairs(x) do
      local k_15_auto, v_16_auto = deep_copy(k), deep_copy(v)
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    return tbl_14_auto
  else
    return x
  end
end
local function deep_merge(x1, x2)
  local _3_ = {x1, x2}
  if ((_G.type(_3_) == "table") and ((_3_)[1] == nil) and ((_3_)[2] == nil)) then
    return nil
  elseif ((_G.type(_3_) == "table") and ((_3_)[1] == nil) and true) then
    local _ = (_3_)[2]
    return deep_copy(x2)
  elseif ((_G.type(_3_) == "table") and true and ((_3_)[2] == nil)) then
    local _ = (_3_)[1]
    return deep_copy(x1)
  else
    local function _4_()
      local _ = _3_
      return (not ("table" == type(x1)) or not ("table" == type(x2)))
    end
    if (true and _4_()) then
      local _ = _3_
      return deep_copy(x1)
    elseif true then
      local _ = _3_
      local acc = deep_copy(x1)
      for k, v in pairs(x2) do
        local function _6_()
          local t_5_ = acc
          if (nil ~= t_5_) then
            t_5_ = (t_5_)[k]
          else
          end
          return t_5_
        end
        acc[k] = deep_merge(v, _6_())
        acc = acc
      end
      return acc
    else
      return nil
    end
  end
end
return {["deep-copy"] = deep_copy, ["deep-merge"] = deep_merge}
