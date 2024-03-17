-- [nfnl] Compiled from fnl/plugins/icons.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("plugins/config/devicon")).setup()
end
local function _2_()
  return (require("plugins/config/codicons")).setup()
end
return {{"kyazdani42/nvim-web-devicons", config = _1_}, {"mortepau/codicons.nvim", config = _2_}}
