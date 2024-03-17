(local config {})

(fn config.setup []
  ((. (require :neoclip) :setup) {:content_spec_column false
                                  :continuous_sync true
                                  :db_path (.. (vim.fn.stdpath :data)
                                               :/databases/neoclip.sqlite3)
                                  :default_register "\""
                                  :default_register_macros :q
                                  :enable_macro_history true
                                  :enable_persistent_history true
                                  :filter (fn [] true)
                                  :history 1000
                                  :keys {:fzf {:custom {}
                                               :paste :ctrl-p
                                               :paste_behind :ctrl-P
                                               :select :default}
                                         :telescope {:i {:custom {}
                                                         :delete :<c-d>
                                                         :paste :<c-p>
                                                         :paste_behind :<c-P>
                                                         :replay :<c-q>
                                                         :select :<cr>}
                                                     :n {:custom {}
                                                         :delete :d
                                                         :paste :p
                                                         :paste_behind :P
                                                         :replay :q
                                                         :select :<cr>}}}
                                  :on_paste {:set_reg false}
                                  :on_replay {:set_reg false}
                                  :preview true}))

config

