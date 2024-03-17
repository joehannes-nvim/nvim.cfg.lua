(local config {})

(vim.cmd "    hi BqfPreviewBorder guifg=#50a14f ctermfg=71
    hi link BqfPreviewRange Search
")

(fn config.setup []
  ((. (require :bqf) :setup) {:auto_enable true
                              :auto_resize_height false
                              :filter {:fzf {:action_for {:ctrl-c :closeall
                                                          :ctrl-q :signtoggle
                                                          :ctrl-t :tabdrop
                                                          :ctrl-v :vsplit
                                                          :ctrl-x :split}
                                             :extra_opts [:--bind
                                                          "ctrl-o:toggle-all"
                                                          :--prompt
                                                          "> "
                                                          :--delimiter
                                                          "|"]}}
                              :func_map {:drop :O
                                         :filter :zn
                                         :filterr :zN
                                         :fzffilter :f
                                         :lastleave :gi
                                         :nextfile :j
                                         :nexthist ">"
                                         :open :<CR>
                                         :openc :o
                                         :prevfile :k
                                         :prevhist "<"
                                         :pscrolldown :<C-d>
                                         :pscrollorig :gg
                                         :pscrollup :<C-u>
                                         :ptoggleauto :P
                                         :ptoggleitem :p
                                         :ptogglemode :<space><CR>
                                         :sclear :z<TAB>
                                         :split :<C-x>
                                         :stogglebuf "'<TAB>"
                                         :stoggledown :<TAB>
                                         :stoggleup :<S-TAB>
                                         :stogglevm :<TAB>
                                         :tab :t<CR>
                                         :tabb :<C-t>
                                         :tabc :to
                                         :tabdrop :tO
                                         :vsplit :<C-v>}
                              :magic_window true
                              :preview {:auto_preview true
                                        :border_chars ["┃"
                                                       "┃"
                                                       "━"
                                                       "━"
                                                       "┏"
                                                       "┓"
                                                       "┗"
                                                       "┛"
                                                       "█"]
                                        :delay_syntax 80
                                        :should_preview_cb (fn [bufnr]
                                                             (var ret true)
                                                             (local filename
                                                                    (vim.api.nvim_buf_get_name bufnr))
                                                             (local fsize
                                                                    (vim.fn.getfsize filename))
                                                             (if (> fsize
                                                                    (* 100 1024))
                                                                 (set ret false)
                                                                 (filename:match "^fugitive://")
                                                                 (set ret false))
                                                             ret)
                                        :win_height 30
                                        :win_vheight 21
                                        :wrap true}}))

config

