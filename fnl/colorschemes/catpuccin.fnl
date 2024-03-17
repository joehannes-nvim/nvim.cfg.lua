(local catppuccino (require :catppuccin))

(catppuccino.setup {:integrations {:barbar false
                                   :bufferline true
                                   :dashboard false
                                   :fern false
                                   :gitgutter false
                                   :gitsigns true
                                   :hop true
                                   :indent_blankline {:colored_indent_levels false
                                                      :enabled false}
                                   :lightspeed false
                                   :lsp_saga true
                                   :lsp_trouble true
                                   :markdown true
                                   :native_lsp {:enabled true
                                                :underlines {:errors :undercurl
                                                             :hints :underdotted
                                                             :information :underline
                                                             :warnings :underdouble}
                                                :virtual_text {:errors :italic
                                                               :hints :italic
                                                               :information :italic
                                                               :warnings :italic}}
                                   :neogit true
                                   :nvimtree {:enabled false :show_root false}
                                   :telescope true
                                   :treesitter true
                                   :ts_rainbow true
                                   :vim_sneak false
                                   :which_key true}
                    :styles {:comments :italic
                             :functions "bold,italic"
                             :keywords :bold
                             :strings :NONE
                             :variables :italic}
                    :term_colors false
                    :transparent_background false})

