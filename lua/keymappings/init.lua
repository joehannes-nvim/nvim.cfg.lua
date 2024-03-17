-- [nfnl] Compiled from fnl/keymappings/init.fnl by https://github.com/Olical/nfnl, do not edit.
local my = _G.my
my.io.apply_keymaps("n", require("keymappings.normal"))
my.io.apply_keymaps("i", require("keymappings.insert"))
my.io.apply_keymaps("t", require("keymappings.terminal"))
my.io.apply_keymaps("v", require("keymappings.visualselect"))
my.io.apply_keymaps("o", require("keymappings.operator"))
return my.io.apply_keymaps("x", require("keymappings.visual"))
