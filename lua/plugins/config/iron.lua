-- [nfnl] Compiled from fnl/plugins/config/iron.fnl by https://github.com/Olical/nfnl, do not edit.
local iron = require("iron")
iron.core.add_repl_definitions({clojure = {lein_connect = {command = {"lein", "repl", ":connect"}}}})
return iron.core.set_config({preferred = {clojure = "lein"}})
