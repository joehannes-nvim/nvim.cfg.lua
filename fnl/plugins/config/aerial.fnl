(local config {})

(vim.cmd "hi link AerialClass Type
hi link AerialClassIcon Special
hi link AerialFunction Special
hi AerialFunctionIcon guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi link AerialLine QuickFixLine
")

(fn config.setup []
  ((. (require :aerial) :setup) {:backends [:treesitter :lsp :markdown]
                                 :close_behavior :global
                                 :close_on_select false
                                 :default_bindings true
                                 :default_direction :left
                                 :disable_max_lines 10000
                                 :filter_kind false
                                 :float {:border :rounded
                                         :max_height 100
                                         :min_height 4}
                                 :guides {:last_item "└─"
                                          :mid_item "├─"
                                          :nested_top "│ "
                                          :whitespace "  "}
                                 :highlight_closest true
                                 :highlight_mode :full_width
                                 :highlight_on_hover false
                                 :highlight_on_jump 300
                                 :ignore {:buftypes :special
                                          :filetypes {}
                                          :unlisted_buffers true
                                          :wintypes :special}
                                 :link_folds_to_tree false
                                 :link_tree_to_folds true
                                 :lsp {:diagnostics_trigger_update true
                                       :update_delay 100
                                       :update_when_errors true}
                                 :manage_folds false
                                 :markdown {:update_delay 300}
                                 :max_width 50
                                 :min_width 30
                                 :nerd_font :auto
                                 :on_attach nil
                                 :open_automatic true
                                 :placement_editor_edge true
                                 :post_jump_cmd "normal! zz"
                                 :show_guides false
                                 :treesitter {:update_delay 100}
                                 :update_events "TextChanged,InsertLeave"}))

config

