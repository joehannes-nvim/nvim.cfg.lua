-- [nfnl] Compiled from fnl/plugins/lines.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("plugins.config.heirline")).setup(true)
end
return {{"SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig"}, {"rebelot/heirline.nvim", config = _1_}}
