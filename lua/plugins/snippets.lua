-- [nfnl] Compiled from fnl/plugins/snippets.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("luasnip.loaders.from_vscode")).lazy_load({paths = {"~/.local/git/joehannes-nvim/snipptes"}})
end
return {{"L3MON4D3/LuaSnip", config = _1_}}
