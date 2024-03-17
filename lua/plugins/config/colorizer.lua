-- [nfnl] Compiled from fnl/plugins/config/colorizer.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
config.setup = function()
  return (require("colorizer")).setup({"*", css = {css = true}, html = {css = true}, javascript = {css = true}})
end
return config
