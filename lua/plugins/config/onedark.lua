-- [nfnl] Compiled from fnl/plugins/config/onedark.fnl by https://github.com/Olical/nfnl, do not edit.
local onedark = require("onedark")
local c = (require("onedark.colors")).load()
return onedark.setup({options = {highlight_cursorline = true}, styles = {comments = "NONE", functions = "italic", keywords = "bold,italic", strings = "NONE", variables = "italic"}})
