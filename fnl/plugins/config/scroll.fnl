(local config {})

(fn config.setup []
  ((. (require :neoscroll) :setup) {:cursor_scrolls_alone true
                                    :easing_function :quadratic
                                    :hide_cursor true
                                    :mappings [:<C-u>
                                               :<C-d>
                                               :<C-b>
                                               :<C-f>
                                               :<C-y>
                                               :<C-e>
                                               :zt
                                               :zz
                                               :zb]
                                    :post_hook (fn [info]
                                                 (when (= info :cursorline)
                                                   (set vim.wo.cursorline true)
                                                   (set vim.wo.cursorcolumn
                                                        true)))
                                    :pre_hook (fn [info]
                                                (when (= info :cursorline)
                                                  (set vim.wo.cursorline false)
                                                  (set vim.wo.cursorcolumn
                                                       false)))
                                    :respect_scrolloff true
                                    :stop_eof true
                                    :use_local_scrolloff false}))

config

