(local my _G.my)
(set vim.opt.termguicolors true)

(local M {})

(fn M.setup []
  (fn highlights []
    (fn vimode-color [] (. my.color.my.vimode (vim.fn.mode)))

    (fn secondary-vimode-color []
      (my.color.fn.background_blend (vimode-color) 73))

    (fn tertiary-vimode-color []
      (my.color.fn.background_blend (vimode-color) 50))

    {:background {:bg (tertiary-vimode-color)
                  :fg my.color.my.theme.bold-retro.primary
                  :force true}
     :buffer {:bg (tertiary-vimode-color) :fg my.color.my.dark :force true}
     :buffer_selected {:bg (vimode-color)
                       :bold true
                       :fg my.color.my.theme.bold-retro.primary
                       :force true}
     :buffer_visible {:bg (secondary-vimode-color)
                      :fg my.color.my.purple
                      :force true}
     :close_button {:bg (tertiary-vimode-color)
                    :fg (. my.color.my (vim.opt.background:get))}
     :close_button_selected {:bg (vimode-color)
                             :bold true
                             :fg my.color.my.theme.bold-retro.primary}
     :close_button_visible {:bg (secondary-vimode-color)
                            :fg my.color.my.theme.bold-retro.primary}
     :diagnostic {:bg (tertiary-vimode-color) :fg my.color.my.theme.bold-retro.attention}
     :diagnostic_selected {:bg (vimode-color)
                           :bold true
                           :fg my.color.my.theme.bold-retro.attention
                           :italic true}
     :diagnostic_visible {:bg (secondary-vimode-color)
                          :bold true
                          :fg my.color.my.theme.bold-retro.attention}
     :error {:bg (tertiary-vimode-color)
             :fg (my.color.util.darken my.color.my.theme.bold-retro.attention 66)}
     :error_diagnostic {:bg (tertiary-vimode-color) :fg my.color.my.theme.bold-retro.attention}
     :error_diagnostic_selected {:bg (vimode-color)
                                 :fg (my.color.util.darken my.color.my.theme.bold-retro.attention 33)}
     :error_diagnostic_visible {:bg (secondary-vimode-color)
                                :fg (my.color.util.darken my.color.my.theme.bold-retro.attention 21)}
     :error_selected {:bg (vimode-color)
                      :fg (my.color.util.darken my.color.my.theme.bold-retro.attention 66)}
     :error_visible {:bg (secondary-vimode-color)
                     :fg (my.color.util.darken my.color.my.theme.bold-retro.attention 66)}
     :fill {:bg my.color.my.theme.bold-retro.primary}
     :hint {:bg (tertiary-vimode-color)
            :fg (my.color.util.darken my.color.my.yellow 66)}
     :hint_diagnostic {:bg (tertiary-vimode-color) :fg my.color.my.yellow}
     :hint_diagnostic_selected {:bg (vimode-color)
                                :fg (my.color.util.darken my.color.my.yellow 33)}
     :hint_diagnostic_visible {:bg (secondary-vimode-color)
                               :fg (my.color.util.darken my.color.my.yellow 21)}
     :hint_selected {:bg (vimode-color)
                     :fg (my.color.util.darken my.color.my.yellow 66)}
     :hint_visible {:bg (secondary-vimode-color)
                    :fg (my.color.util.darken my.color.my.yellow 66)}
     :info {:bg (tertiary-vimode-color)
            :fg (my.color.util.darken my.color.my.blue 66)}
     :info_diagnostic {:bg (tertiary-vimode-color) :fg my.color.my.blue}
     :info_diagnostic_selected {:bg (vimode-color)
                                :fg (my.color.util.darken my.color.my.blue 33)}
     :info_diagnostic_visible {:bg (secondary-vimode-color)
                               :fg (my.color.util.darken my.color.my.blue 21)}
     :info_selected {:bg (vimode-color)
                     :fg (my.color.util.darken my.color.my.blue 66)}
     :info_visible {:bg (secondary-vimode-color)
                    :fg (my.color.util.darken my.color.my.blue 66)}
     :modified {:bg (tertiary-vimode-color) :fg my.color.my.theme.bold-retro.attention}
     :modified_selected {:bg (vimode-color) :fg my.color.my.theme.bold-retro.attention}
     :modified_visible {:bg (secondary-vimode-color) :fg my.color.my.theme.bold-retro.attention}
     :pick_selected {:bg (. my.color.my (vim.opt.background:get))
                     :fg (vimode-color)}
     :separator {:bg (tertiary-vimode-color) :fg my.color.my.theme.bold-retro.primary}
     :separator_selected {:bg (vimode-color) :fg my.color.my.theme.bold-retro.primary}
     :separator_visible {:bg (secondary-vimode-color) :fg my.color.my.theme.bold-retro.primary}
     :tab {:bg (tertiary-vimode-color)}
     :tab_close {:bg (vimode-color) :bold true :fg my.color.my.dark}
     :tab_selected {:bg (vimode-color) :bold true :fg my.color.my.light}
     :warning {:bg (tertiary-vimode-color)
               :fg (my.color.util.darken my.color.my.orange 66)}
     :warning_diagnostic {:bg (tertiary-vimode-color) :fg my.color.my.orange}
     :warning_diagnostic_selected {:bg (vimode-color)
                                   :fg (my.color.util.darken my.color.my.orange
                                                             33)}
     :warning_diagnostic_visible {:bg (secondary-vimode-color)
                                  :fg (my.color.util.darken my.color.my.orange
                                                            21)}
     :warning_selected {:bg (vimode-color)
                        :fg (my.color.util.darken my.color.my.orange 66)}
     :warning_visible {:bg (secondary-vimode-color)
                       :fg (my.color.util.darken my.color.my.orange 66)}})

  (local opts {:highlights (highlights)
               :options {:always_show_bufferline true
                         :buffer_close_icon ""
                         :close_command "bp | silent! bd! %d"
                         :close_icon ""
                         :custom_areas {}
                         :custom_filter (fn [buf-number]
                                          (when (not (not (: (vim.api.nvim_buf_get_name buf-number)
                                                             :find
                                                             (vim.fn.getcwd) 0
                                                             true)))
                                            true))
                         :diagnostics :nvim_lsp
                         :diagnostics_indicator (fn [count
                                                     level
                                                     diagnostics-dict
                                                     context]
                                                  (var s " ")
                                                  (each [e n (pairs diagnostics-dict)]
                                                    (local sym
                                                           (or (and (= e :error)
                                                                    " ")
                                                               (or (and (= e
                                                                           :warning)
                                                                        " ")
                                                                   " ")))
                                                    (set s (.. s n sym)))
                                                  s)
                         :enforce_regular_tabs false
                         :indicator {:icon "▎" :style :icon}
                         :left_mouse_command "buffer %d"
                         :left_trunc_marker ""
                         :max_name_length 21
                         :max_prefix_length 15
                         :middle_mouse_command "sbuffer %d"
                         :modified_icon "●"
                         :name_formatter (fn [buf]
                                           (vim.fn.fnamemodify buf.name ":t"))
                         :numbers :none
                         :persist_buffer_sort true
                         :right_mouse_command "sbuffer %d"
                         :right_trunc_marker ""
                         :separator_style :slope
                         :show_buffer_close_icons true
                         :show_buffer_icons true
                         :show_close_icon true
                         :show_tab_indicators true
                         :sort_by (fn [buffer-a buffer-b]
                                    (local mod-a
                                           (or (. (or (. (or (vim.loop.fs_stat buffer-a.path)
                                                             {})
                                                         :atime)
                                                      {})
                                                  :sec)
                                               0))
                                    (local mod-b
                                           (or (. (or (. (or (vim.loop.fs_stat buffer-b.path)
                                                             {})
                                                         :atime)
                                                      {})
                                                  :sec)
                                               0))
                                    (> mod-a mod-b))
                         :tab_size 7}})
  ((. (require :bufferline) :setup) opts))

M

