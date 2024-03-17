(local M {})

(fn M.setup []
  ((. (require :gitsigns) :setup) {:attach_to_untracked true
                                   :current_line_blame true
                                   :current_line_blame_formatter "<author>, <author_time:%Y-%m-%d> - <summary>"
                                   :current_line_blame_opts {:delay 300
                                                             :ignore_whitespace false
                                                             :virt_text true
                                                             :virt_text_pos :eol}
                                   :linehl false
                                   :max_file_length 40000
                                   :numhl true
                                   :on_attach (fn [bufnr]
                                                (local gs
                                                       package.loaded.gitsigns)

                                                (fn map [mode l r opts]
                                                  (set-forcibly! opts
                                                                 (or opts {}))
                                                  (set opts.buffer bufnr)
                                                  (vim.keymap.set mode l r opts))

                                                (map [:o :x] :ih
                                                     ":<C-U>Gitsigns select_hunk<CR>"))
                                   :preview_config {:border :single
                                                    :col 1
                                                    :relative :cursor
                                                    :row 0
                                                    :style :minimal}
                                   :sign_priority 6
                                   :signcolumn true
                                   :signs {:add {:hl :GitSignsAdd
                                                 :linehl :GitSignsAddLn
                                                 :numhl :GitSignsAddNr
                                                 :text "+"}
                                           :change {:hl :GitSignsChange
                                                    :linehl :GitSignsChangeLn
                                                    :numhl :GitSignsChangeNr
                                                    :text "│"}
                                           :changedelete {:hl :GitSignsChange
                                                          :linehl :GitSignsChangeLn
                                                          :numhl :GitSignsChangeNr
                                                          :text "~"}
                                           :delete {:hl :GitSignsDelete
                                                    :linehl :GitSignsDeleteLn
                                                    :numhl :GitSignsDeleteNr
                                                    :text "_"}
                                           :topdelete {:hl :GitSignsDelete
                                                       :linehl :GitSignsDeleteLn
                                                       :numhl :GitSignsDeleteNr
                                                       :text "‾"}}
                                   :status_formatter nil
                                   :update_debounce 100
                                   :watch_gitdir {:follow_files true
                                                  :interval 1000}
                                   :word_diff false
                                   :yadm {:enable false}}))

M

