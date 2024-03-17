(local fs (require :efmls-configs.fs))

(local linter :clj-kondo)

(local command (string.format "%s --lang cljs --lint -" (fs.executable linter)))

{:lintCommand command
 :lintFormats ["%.%#:%l:%c: %trror: %m"
               "%.%#:%l:%c: %tarning: %m"
               "%.%#:%l:%c: %tote: %m"]
 :lintStdin true
 :prefix linter
 :rootMarkers [:.clj-kondo/config.edn]}

