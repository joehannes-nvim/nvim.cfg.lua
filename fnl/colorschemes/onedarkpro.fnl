(local my _G.my)
(local onedarkpro (require :onedarkpro))

(local odp-utils (require :onedarkpro.utils))

(onedarkpro.setup {:colors {:bg my.color.my.dark
                            :black my.color.my.dark
                            :blue my.color.my.blue
                            :color_column ((. odp-utils
                                              (or (and (= (vim.opt.background:get)
                                                          :dark)
                                                       :lighten)
                                                  :darken)) my.color.my.dark
                                                                                                                                                                                                                                                                                                                                         0.98)
                            :comment ((. odp-utils
                                         (or (and (= (vim.opt.background:get)
                                                     :dark)
                                                  :lighten)
                                             :darken)) my.color.my.dark
                                                                                                                                                                                                                                                                                                                0.8)
                            :cursorline ((. odp-utils
                                            (or (and (= (vim.opt.background:get)
                                                        :dark)
                                                     :lighten)
                                                :darken)) my.color.my.dark
                                                                                                                                                                                                                                                                                                                               0.97)
                            :cyan my.color.my.aqua
                            :fg my.color.my.light
                            :gray (odp-utils.lighten my.color.my.dark 0.5)
                            :green my.color.my.green
                            :highlight my.color.my.yellow
                            :indentline ((. odp-utils
                                            (or (and (= (vim.opt.background:get)
                                                        :dark)
                                                     :lighten)
                                                :darken)) my.color.my.dark
                                                                                                                                                                                                                                                                                                                               0.93)
                            :menu ((. odp-utils
                                      (or (and (= (vim.opt.background:get)
                                                  :dark)
                                               :lighten)
                                          :darken)) my.color.my.dark
                                                                                                                                                                                                                                                                                                 0.95)
                            :menu_scroll ((. odp-utils
                                             (or (and (= (vim.opt.background:get)
                                                         :dark)
                                                      :lighten)
                                                 :darken)) my.color.my.dark
                                                                                                                                                                                                                                                                                                                                    0.9)
                            :menu_scroll_thumb ((. odp-utils
                                                   (or (and (= (vim.opt.background:get)
                                                               :dark)
                                                            :lighten)
                                                       :darken)) my.color.my.blue
                                                                                                                                                                                                                                                                                                                                                                  0.8)
                            :orange my.color.my.orange
                            :purple my.color.my.purple
                            :red my.color.my.red
                            :selection ((. odp-utils
                                           (or (and (= (vim.opt.background:get)
                                                       :dark)
                                                    :lighten)
                                               :darken)) my.color.my.dark
                                                                                                                                                                                                                                                                                                                          0.9)
                            :white my.color.my.light
                            :yellow my.color.my.yellow}
                   :options {:bold true
                             :cursorline true
                             :italic true
                             :terminal_colors true
                             :transparency false
                             :undercurl true
                             :underline true
                             :window_unfocused_color true}
                   :styles {:comments :italic
                            :functions "italic,bold"
                            :keywords :bold
                            :strings :NONE
                            :variables :italic}})

