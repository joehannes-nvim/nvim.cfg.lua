-- [nfnl] Compiled from fnl/plugins/config/lspcolors.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
config.setup = function()
  return (require("lsp-colors")).setup({Error = "#db0b0b", Hint = "#10B981", Information = "#0db9d7", Warning = "#f97f58"})
end
return config
