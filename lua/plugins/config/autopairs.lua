-- [nfnl] Compiled from fnl/plugins/config/autopairs.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
config.setup = function()
  do end (require("nvim-ts-autotag")).setup()
  return (require("nvim-autopairs")).setup({})
end
return config
