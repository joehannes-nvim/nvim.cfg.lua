[{1 :dnlhc/glance.nvim
  :config (fn []
            (local glance (require :glance))
            (local actions glance.actions)
            (glance.setup {:border {:bottom_char "="
                                    :enable true
                                    :top_char "="}
                           :folds {:fold_closed ""
                                   :fold_open ""
                                   :folded true}
                           :height 18
                           :hooks {}
                           :indent_lines {:enable true :icon "│"}
                           :list {:position :right :width 0.33}
                           :mappings {:list {:<C-d> (actions.preview_scroll_win (- 5))
                                             :<C-u> (actions.preview_scroll_win 5)
                                             :<CR> (actions.enter_win :preview)
                                             :<Down> actions.next
                                             :<Esc> actions.close
                                             :<S-Tab> actions.previous_location
                                             :<Tab> actions.next_location
                                             :<Up> actions.previous
                                             :<leader>l (actions.enter_win :preview)
                                             :Q actions.close
                                             :j actions.next
                                             :k actions.previous
                                             :o actions.jump
                                             :q actions.close
                                             :s actions.jump_split
                                             :t actions.jump_tab
                                             :v actions.jump_vsplit}
                                      :preview {:<S-Tab> actions.previous_location
                                                :<Tab> actions.next_location
                                                :<leader>l (actions.enter_win :list)
                                                :Q actions.close}}
                           :preview_win_opts {:cursorline true
                                              :number true
                                              :wrap true}
                           :theme {:enable true :mode :auto}
                           :winbar {:enable false}
                           :zindex 45}))}
 {1 :lewis6991/hover.nvim
  :config (fn []
            ((. (require :hover) :setup) {:init (fn []
                                                  (require :hover.providers.lsp)
                                                  (require :hover.providers.gh)
                                                  (require :hover.providers.gh_user)
                                                  (require :hover.providers.man)
                                                  (require :hover.providers.dictionary))
                                          :preview_opts {:border :rounded
                                                         :winbar nil}
                                          :title true
                                          :winbar nil}))}
 {1 :sunaku/vim-dasht
  :config (fn []
            (vim.cmd "        let g:dasht_results_window = 'tabnew'\n      "))}]

