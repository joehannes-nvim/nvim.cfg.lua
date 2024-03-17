-- [nfnl] Compiled from fnl/plugins/config/notify.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
config.setup = function()
  local notify = require("notify")
  local function _1_()
    local output = "#F634B1"
    if ((vim.opt.background):get() == "light") then
      output = "#F737C7"
    else
      output = "#F73090"
    end
    return output
  end
  notify.setup({background_colour = _1_, icons = {DEBUG = "\239\134\136", ERROR = "\239\129\151", INFO = "\239\129\154", TRACE = "\226\156\142", WARN = "\239\129\170"}, minimum_width = 70, render = "default", stages = "fade", timeout = 7000})
  vim.notify = notify
  return nil
end
return config
