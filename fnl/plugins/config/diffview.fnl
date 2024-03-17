(local config {})

(fn cb [str]
  ((. (require :diffview.config) :diffview_callback) str))

(fn config.setup []
  ((. (require :diffview) :setup) {:diff_binaries false
                                   :enhanced_diff_hl false
                                   :file_history_panel {:win_config {:height 21
                                                                     :position :bottom
                                                                     :width 35}}
                                   :file_panel {:listing_style :tree
                                                :tree_options {:flatten_dirs true
                                                               :folder_statuses :always}
                                                :win_config {:height 10
                                                             :position :left
                                                             :width 35}}
                                   :icons {:folder_closed ""
                                           :folder_open ""}
                                   :key_bindings {:disable_defaults false
                                                  :file_history_panel {:<2-LeftMouse> (cb :select_entry)
                                                                       :<C-d> (cb :open_in_diffview)
                                                                       :<C-w><C-f> (cb :goto_file_split)
                                                                       :<C-w>gf (cb :goto_file_tab)
                                                                       :<cr> (cb :select_entry)
                                                                       :<down> (cb :next_entry)
                                                                       :<leader>b (cb :toggle_files)
                                                                       :<leader>e (cb :focus_files)
                                                                       :<s-tab> (cb :select_prev_entry)
                                                                       :<tab> (cb :select_next_entry)
                                                                       :<up> (cb :prev_entry)
                                                                       :g! (cb :options)
                                                                       :gf (cb :goto_file)
                                                                       :j (cb :next_entry)
                                                                       :k (cb :prev_entry)
                                                                       :o (cb :select_entry)
                                                                       :zM (cb :close_all_folds)
                                                                       :zR (cb :open_all_folds)}
                                                  :file_panel {:- (cb :toggle_stage_entry)
                                                               :<2-LeftMouse> (cb :select_entry)
                                                               :<C-w><C-f> (cb :goto_file_split)
                                                               :<C-w>gf (cb :goto_file_tab)
                                                               :<cr> (cb :select_entry)
                                                               :<down> (cb :next_entry)
                                                               :<leader>b (cb :toggle_files)
                                                               :<leader>e (cb :focus_files)
                                                               :<s-tab> (cb :select_prev_entry)
                                                               :<tab> (cb :select_next_entry)
                                                               :<up> (cb :prev_entry)
                                                               :R (cb :refresh_files)
                                                               :S (cb :stage_all)
                                                               :U (cb :unstage_all)
                                                               :X (cb :restore_entry)
                                                               :f (cb :toggle_flatten_dirs)
                                                               :gf (cb :goto_file)
                                                               :i (cb :listing_style)
                                                               :j (cb :next_entry)
                                                               :k (cb :prev_entry)
                                                               :o (cb :select_entry)}
                                                  :option_panel {:<tab> (cb :select)
                                                                 :q (cb :close)}
                                                  :view {:<C-w><C-f> (cb :goto_file_split)
                                                         :<C-w>gf (cb :goto_file_tab)
                                                         :<leader>b (cb :toggle_files)
                                                         :<leader>e (cb :focus_files)
                                                         :<s-tab> (cb :select_prev_entry)
                                                         :<tab> (cb :select_next_entry)
                                                         :gf (cb :goto_file)}}
                                   :signs {:fold_closed "" :fold_open ""}
                                   :use_icons true}))

config

