-- [nfnl] Compiled from fnl/plugins/lines.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("plugins.config.heirline")).setup(true)
end
local function _2_()
  return (require("plugins.config.bufferline")).setup()
end
return {{"SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig"}, {"rebelot/heirline.nvim", config = _1_}, {"akinsho/bufferline.nvim", config = _2_, dependencies = "kyazdani42/nvim-web-devicons"}}
