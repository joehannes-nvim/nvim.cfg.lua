(local M {})

(fn M.setup []
  ((. (require :zen-mode) :setup) {:on_close (fn []
                                               (vim.defer_fn (fn []
                                                               (set vim.go.cmdheight
                                                                    1))
                                                 0))
                                   :on_open (fn [win]
                                              (vim.defer_fn (fn [] (vim.cmd :e)
                                                              (set vim.wo.foldmethod
                                                                   :expr)
                                                              (set vim.go.cmdheight
                                                                   0))
                                                100))
                                   :plugins {:gitsigns {:enabled false}
                                             :kitty {:enabled true :font :+2}
                                             :options {:enabled false
                                                       :ruler false
                                                       :showcmd false}
                                             :tmux {:enabled true}
                                             :twilight {:enabled true}}
                                   :window {:backdrop 0.5
                                            :height 0.98
                                            :options {:cursorcolumn true
                                                      :cursorline true
                                                      :foldcolumn :1
                                                      :list true
                                                      :number true
                                                      :relativenumber true
                                                      :signcolumn "auto:3"}
                                            :width 130}}))

M

