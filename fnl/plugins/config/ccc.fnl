(local M {})

(fn M.setup []
  (let [ccc (require :ccc)]
    (ccc.setup {:inputs [ccc.input.rgb ccc.input.hsl] :save_on_quit true})))

M

