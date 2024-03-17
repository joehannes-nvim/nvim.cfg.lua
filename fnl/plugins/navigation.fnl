[{1 :chentoast/marks.nvim
  :config (fn []
            ((. (require :marks) :setup) {:bookmark_0 {:sign ""
                                                       :virt_text " ( 0) "}
                                          :bookmark_1 {:sign ""
                                                       :virt_text " ( 1) "}
                                          :bookmark_2 {:sign ""
                                                       :virt_text " ( 2) "}
                                          :bookmark_3 {:sign ""
                                                       :virt_text " ( 3) "}
                                          :bookmark_4 {:sign ""
                                                       :virt_text " ( 4) "}
                                          :bookmark_5 {:sign ""
                                                       :virt_text " ( 5) "}
                                          :bookmark_6 {:sign ""
                                                       :virt_text " ( 6) "}
                                          :bookmark_7 {:sign ""
                                                       :virt_text " ( 7) "}
                                          :bookmark_8 {:sign ""
                                                       :virt_text " ( 8) "}
                                          :bookmark_9 {:sign ""
                                                       :virt_text " ( 9) "}
                                          :default_mappings true
                                          :mappings {:annotate "m@"
                                                     :m0 false
                                                     :m1 false
                                                     :m2 false
                                                     :m3 false
                                                     :m4 false
                                                     :m5 false
                                                     :m6 false
                                                     :m7 false
                                                     :m8 false
                                                     :m9 false}}))}
 {1 :cbochs/portal.nvim
  :config (fn []
            ((. (require :plugins.config.portal) :setup)))
  :dependencies [:cbochs/grapple.nvim :ThePrimeagen/harpoon]}
 {1 :phaazon/hop.nvim
  :as :hop
  :branch :v2
  :config (fn []
            (local hop (require :hop))
            (local directions (. (require :hop.hint) :HintDirection))
            (hop.setup {:keys :etovxqpdygfblzhckisuran})
            (vim.keymap.set "" :f
                            (fn []
                              (hop.hint_char1 {:current_line_only true
                                               :direction directions.AFTER_CURSOR}))
                            {:remap true})
            (vim.keymap.set "" :F
                            (fn []
                              (hop.hint_char1 {:current_line_only true
                                               :direction directions.BEFORE_CURSOR}))
                            {:remap true})
            (vim.keymap.set "" :t
                            (fn []
                              (hop.hint_char1 {:current_line_only true
                                               :direction directions.AFTER_CURSOR
                                               :hint_offset (- 1)}))
                            {:remap true})
            (vim.keymap.set "" :T
                            (fn []
                              (hop.hint_char1 {:current_line_only true
                                               :direction directions.BEFORE_CURSOR
                                               :hint_offset 1}))
                            {:remap true}))}
 {1 :SmiteshP/nvim-navbuddy
  :config (fn []
            ((. (require :plugins.config.navbuddy) :setup)))
  :dependencies [:neovim/nvim-lspconfig
                 :SmiteshP/nvim-navic
                 :MunifTanjim/nui.nvim
                 :nvim-telescope/telescope.nvim]}
 {1 :LeonHeidelbach/trailblazer.nvim
  :config (fn []
            ((. (require :trailblazer) :setup) [{:auto_load_trailblazer_state_on_enter true
                                                 :auto_save_trailblazer_state_on_exit true
                                                 :custom_session_storage_dir "~/.local/share/nvim/sessions/"
                                                 :event_list {}
                                                 :lang :en
                                                 :mappings {:nv {:actions {}
                                                                 :motions {}}}
                                                 :quickfix_mappings {:nv {:actions {:qf_action_delete_trail_mark_selection :d
                                                                                    :qf_action_save_visual_selection_start_line :v}
                                                                          :alt_actions {:qf_action_save_visual_selection_start_line :V}
                                                                          :motions {:qf_motion_move_trail_mark_stack_cursor :<CR>}}
                                                                     :v {:actions {:qf_action_move_selected_trail_marks_down :<C-j>
                                                                                   :qf_action_move_selected_trail_marks_up :<C-k>}}}
                                                 :trail_options {:available_trail_mark_modes [:global_chron
                                                                                              :global_buf_line_sorted
                                                                                              :global_fpath_line_sorted
                                                                                              :global_chron_buf_line_sorted
                                                                                              :global_chron_fpath_line_sorted
                                                                                              :global_chron_buf_switch_group_chron
                                                                                              :global_chron_buf_switch_group_line_sorted
                                                                                              :buffer_local_chron
                                                                                              :buffer_local_line_sorted]
                                                                 :available_trail_mark_stack_sort_modes [:alpha_asc
                                                                                                         :alpha_dsc
                                                                                                         :chron_asc
                                                                                                         :chron_dsc]
                                                                 :current_trail_mark_list_type :quickfix
                                                                 :current_trail_mark_mode :global_chron
                                                                 :current_trail_mark_stack_sort_mode :chron_asc
                                                                 :cursor_mark_symbol "⦁"
                                                                 :default_trail_mark_stacks [:default]
                                                                 :mark_symbol "•"
                                                                 :move_to_nearest_before_peek false
                                                                 :move_to_nearest_before_peek_dist_type :lin_char_dist
                                                                 :move_to_nearest_before_peek_motion_directive_down :fpath_down
                                                                 :move_to_nearest_before_peek_motion_directive_up :fpath_up
                                                                 :multiple_mark_symbol_counters_enabled true
                                                                 :newest_mark_symbol "🔥"
                                                                 :next_mark_symbol "⤷"
                                                                 :number_line_color_enabled true
                                                                 :previous_mark_symbol "⤶"
                                                                 :symbol_line_enabled true
                                                                 :trail_mark_in_text_highlights_enabled true
                                                                 :trail_mark_list_rows 10
                                                                 :trail_mark_priority 10001
                                                                 :trail_mark_symbol_line_indicators_enabled false
                                                                 :verbose_trail_mark_select true}}]))}]

