(local config {})

(fn config.setup []
  ((. (require :nvim-ts-autotag) :setup))
  ((. (require :nvim-autopairs) :setup) {}))

config

