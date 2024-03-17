(local config {})

(fn config.setup []
  ((. (require :colorizer) :setup) {1 "*"
                                    :css {:css true}
                                    :html {:css true}
                                    :javascript {:css true}}))

config

