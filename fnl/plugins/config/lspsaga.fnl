(local config {})

(local saga (require :lspsaga))

(fn config.setup []
  (saga.setup {:finder_action_keys {:open :o
                                    :quit :q
                                    :scroll_down :<C-f>
                                    :scroll_up :<C-b>
                                    :split :i
                                    :vsplit :s}
               :max_preview_lines 21}))

config

