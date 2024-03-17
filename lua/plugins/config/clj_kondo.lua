-- [nfnl] Compiled from fnl/plugins/config/clj_kondo.fnl by https://github.com/Olical/nfnl, do not edit.
local fs = require("efmls-configs.fs")
local linter = "clj-kondo"
local command = string.format("%s --lang cljs --lint -", fs.executable(linter))
return {lintCommand = command, lintFormats = {"%.%#:%l:%c: %trror: %m", "%.%#:%l:%c: %tarning: %m", "%.%#:%l:%c: %tote: %m"}, lintStdin = true, prefix = linter, rootMarkers = {".clj-kondo/config.edn"}}
