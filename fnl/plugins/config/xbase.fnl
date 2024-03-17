(local M {})

(fn M.setup []
  ((. (require :xbase) :setup) {:log_buffer {:default_direction :horizontal
                                             :focus true
                                             :height 20
                                             :width 75}
                                :log_level vim.log.levels.DEBUG
                                :mappings {:all_picker :<leader>x<cr>!
                                           :build_picker :<leader>x<cr>b
                                           :enable true
                                           :run_picker :<leader>x<cr>r
                                           :toggle_split_log_buffer :<leader>tlxs
                                           :toggle_vsplit_log_buffer :<leader>tlxv
                                           :watch_picker :<leader>x<cr>w}
                                :simctl {:iOS {} :tvOS {} :watchOS {}}
                                :sourcekit {}
                                :statusline {:device_running {:color "#4a6edb"
                                                              :icon ""}
                                             :failure {:color "#db4b4b"
                                                       :icon ""}
                                             :success {:color "#1abc9c"
                                                       :icon ""}
                                             :watching {:color "#1abc9c"
                                                        :icon ""}}}))

M

