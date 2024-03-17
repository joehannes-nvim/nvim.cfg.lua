(local config {})

(fn config.setup []
  (let [codicons (require :codicons)] (codicons.setup {})))

config

