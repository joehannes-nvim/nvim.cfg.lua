(local config {})

(fn config.setup []
  (let [opts {:action_keys {:cancel :<esc>
                            :close :q
                            :close_folds [:zM :zm]
                            :hover :K
                            :jump [:<cr> :<tab>]
                            :jump_close [:o]
                            :next :j
                            :open_folds [:zR :zr]
                            :open_split [:<c-x>]
                            :open_tab [:<c-t>]
                            :open_vsplit [:<c-v>]
                            :preview :p
                            :previous :k
                            :refresh :r
                            :toggle_fold [:zA :za]
                            :toggle_mode :m
                            :toggle_preview :P}
              :auto_close true
              :auto_fold false
              :auto_jump {}
              :auto_open true
              :auto_preview true
              :fold_closed ""
              :fold_open ""
              :group true
              :height 17
              :icons true
              :indent_lines true
              :mode :lsp_references
              :padding true
              :position :bottom
              :signs {:error ""
                      :hint ""
                      :information ""
                      :other "﫠"
                      :warning ""}
              :use_diagnostic_signs false
              :width 50}]
    ((. (require :trouble) :setup) opts)))

config

