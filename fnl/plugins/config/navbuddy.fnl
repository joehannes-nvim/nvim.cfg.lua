(local M {})

(fn M.setup []
  (let [navbuddy (require :nvim-navbuddy)
        actions (require :nvim-navbuddy.actions)]
    (navbuddy.setup {:icons {:Array " "
                             :Boolean "◩ "
                             :Class " "
                             :Constant " "
                             :Constructor " "
                             :Enum "練"
                             :EnumMember " "
                             :Event " "
                             :Field " "
                             :File " "
                             :Function " "
                             :Interface "練"
                             :Key " "
                             :Method " "
                             :Module " "
                             :Namespace " "
                             :Null "ﳠ "
                             :Number " "
                             :Object " "
                             :Operator " "
                             :Package " "
                             :Property " "
                             :String " "
                             :Struct " "
                             :TypeParameter " "
                             :Variable " "}
                     :lsp {:auto_attach true :preference nil}
                     :mappings {:0 (actions.root)
                                :<enter> (actions.select)
                                :<esc> (actions.close)
                                :A (actions.append_scope)
                                :F (actions.fold_delete)
                                :I (actions.insert_scope)
                                :J (actions.move_down)
                                :K (actions.move_up)
                                :V (actions.visual_scope)
                                :Y (actions.yank_scope)
                                :a (actions.append_name)
                                :c (actions.comment)
                                :d (actions.delete)
                                :f (actions.fold_create)
                                :g? (actions.help)
                                :h (actions.parent)
                                :i (actions.insert_name)
                                :j (actions.next_sibling)
                                :k (actions.previous_sibling)
                                :l (actions.children)
                                :o (actions.select)
                                :q (actions.close)
                                :r (actions.rename)
                                :t (actions.telescope {:layout_config {:height 0.6
                                                                       :preview_width 0.5
                                                                       :prompt_position :top
                                                                       :width 0.6}
                                                       :layout_strategy :horizontal})
                                :v (actions.visual_name)
                                :y (actions.yank_name)}
                     :node_markers {:cons {:branch " "
                                           :eaf "  "
                                           :eaf_selected " → "}
                                    :enabled true}
                     :source_buffer {:follow_node true
                                     :highlight true
                                     :reorient :smart}
                     :use_default_mappings true
                     :window {:border :single
                              :position "50%"
                              :sections {:left {:border nil :size "20%"}
                                         :mid {:border nil :size "40%"}
                                         :right {:border nil}}
                              :size "60%"}})))

M

