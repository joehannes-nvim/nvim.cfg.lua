(set vim.go.foldexpr "nvim_treesitter#foldexpr()")

(local M {})

(fn M.ts_setup []
  ((. (require :nvim-treesitter.configs) :setup) {:autopairs {:enable true}
                                                  :autotag {:enable true}
                                                  :ensure_installed :all
                                                  :highlight {:disable {}
                                                              :enable true}
                                                  :incremental_selection {:enable true
                                                                          :keymaps {:init_selection :<leader>v
                                                                                    :node_decremental "S["
                                                                                    :node_incremental "s["
                                                                                    :scope_incremental "s{"}}
                                                  :indent {:enable true}
                                                  :rainbow {:enable true
                                                            :extended_mode true
                                                            :max_file_lines nil}
                                                  :refactor {:smart_rename {:enable false
                                                                            :keymaps {:smart_rename nil}}}
                                                  :textobjects {:move {:enable true
                                                                       :goto_next_end {"]A?" "@conditional.outer"
                                                                                       "]Ab" "@block.outer"
                                                                                       "]Af" "@function.outer"
                                                                                       "]Am" "@class.outer"
                                                                                       "]Ax" "@loop.outer"
                                                                                       "]I?" "@conditional.inner"
                                                                                       "]Ib" "@block.inner"
                                                                                       "]If" "@function.inner"
                                                                                       "]Im" "@class.inner"
                                                                                       "]Ix" "@loop.inner"}
                                                                       :goto_next_start {"]a?" "@conditional.outer"
                                                                                         "]ab" "@block.outer"
                                                                                         "]af" "@function.outer"
                                                                                         "]am" "@class.outer"
                                                                                         "]ax" "@loop.outer"
                                                                                         "]i?" "@conditional.inner"
                                                                                         "]ib" "@block.inner"
                                                                                         "]if" "@function.inner"
                                                                                         "]im" "@class.inner"
                                                                                         "]ix" "@loop.inner"}
                                                                       :goto_previous_end {"[A?" "@conditional.outer"
                                                                                           "[Ab" "@block.outer"
                                                                                           "[Af" "@function.outer"
                                                                                           "[Am" "@class.outer"
                                                                                           "[Ax" "@loop.outer"
                                                                                           "[I?" "@conditional.inner"
                                                                                           "[Ib" "@block.inner"
                                                                                           "[If" "@function.inner"
                                                                                           "[Im" "@class.inner"
                                                                                           "[Ix" "@loop.inner"}
                                                                       :goto_previous_start {"[a?" "@conditional.outer"
                                                                                             "[ab" "@block.outer"
                                                                                             "[af" "@function.outer"
                                                                                             "[am" "@class.outer"
                                                                                             "[ax" "@loop.outer"
                                                                                             "[i?" "@conditional.inner"
                                                                                             "[ib" "@block.inner"
                                                                                             "[if" "@function.inner"
                                                                                             "[im" "@class.inner"
                                                                                             "[ix" "@loop.inner"}
                                                                       :set_jumps true}
                                                                :select {:enable true
                                                                         :keymaps {:a? "@conditional.outer"
                                                                                   :ab "@block.outer"
                                                                                   :af "@function.outer"
                                                                                   :am "@class.outer"
                                                                                   :ax "@loop.outer"
                                                                                   :i? "@conditional.inner"
                                                                                   :ib "@block.inner"
                                                                                   :if "@function.inner"
                                                                                   :im "@class.inner"
                                                                                   :ix "@loop.inner"}
                                                                         :lookahead true}}
                                                  :textsubjects {:enable true
                                                                 :keymaps {:. :textsubjects-smart
                                                                           ";" :textsubjects-container-outer}
                                                                 :prev_selection ","}}))

(fn M.ts_refactor_setup []
  ((. (require :nvim-treesitter.configs) :setup) {:autotag {:enable true
                                                            :highlight {:enable true
                                                                        :highlight_delay 200
                                                                        :highlight_group :TSRefactorHighlight
                                                                        :highlight_method :block}}
                                                  :rainbow {:enable true
                                                            :extended_mode false}
                                                  :refactor {:highlight_current_scope {:enable false}
                                                             :highlight_definitions {:clear_on_cursor_move true
                                                                                     :enable true}
                                                             :navigation {:enable true
                                                                          :keymaps {:goto_next_usage :<leader>*
                                                                                    :goto_previous_usage "<leader>#"}}}}))

(fn M.ts_vto_setup []
  ((. (require :various-textobjs) :setup) {:useDefaultKeymaps true}))

M

