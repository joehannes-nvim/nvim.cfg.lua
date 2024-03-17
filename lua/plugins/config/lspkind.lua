-- [nfnl] Compiled from fnl/plugins/config/lspkind.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
config.setup = function()
  return (require("lspkind")).init({mode = "symbol_text", preset = "default", symbol_map = {Class = "\238\131\141", Color = "\238\136\171", Constant = "\238\136\172", Constructor = "\238\136\143", Enum = "\228\186\134", EnumMember = "\239\133\157", File = "\239\133\155", Folder = "\239\132\149", Function = "\239\130\154", Interface = "\239\176\174", Keyword = "\239\160\133", Method = "\198\146", Module = "\239\163\150", Property = "\238\152\164", Snippet = "\239\172\140", Struct = "\239\131\138", Text = "\238\152\146", Unit = "\239\145\181", Value = "\239\162\159", Variable = "\238\158\155"}})
end
return config
