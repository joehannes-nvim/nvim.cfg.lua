(local config {})

(fn config.setup []
  ((. (require :lsp-colors) :setup) {:Error "#db0b0b"
                                     :Hint "#10B981"
                                     :Information "#0db9d7"
                                     :Warning "#f97f58"}))

config

