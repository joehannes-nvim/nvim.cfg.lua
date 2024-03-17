(local M {})

(local wilder (require :wilder))

(wilder.set_option :use_python_remote_plugin 0)

(fn M.setup []
  (let [popupmenu-renderer (wilder.popupmenu_renderer (wilder.popupmenu_border_theme {:border :rounded
                                                                                      :empty_message (wilder.popupmenu_empty_message_with_spinner)
                                                                                      :highlighter (wilder.basic_highlighter)
                                                                                      :left [" "
                                                                                             (wilder.popupmenu_devicons)
                                                                                             (wilder.popupmenu_buffer_flags {:flags " a + "
                                                                                                                             :icons {:+ ""
                                                                                                                                     :a ""
                                                                                                                                     :h ""}})]
                                                                                      :mode :popup
                                                                                      :pumblend 20
                                                                                      :right [" "
                                                                                              (wilder.popupmenu_scrollbar)]}))
        palette-renderer (wilder.popupmenu_renderer (wilder.popupmenu_palette_theme {:border :double
                                                                                     :max_height "75%"
                                                                                     :min_height "25%"
                                                                                     :pre_hook (fn [ctx]
                                                                                                 (set vim.opt_local.winbar
                                                                                                      nil))
                                                                                     :prompt_position :top
                                                                                     :pumblend 50
                                                                                     :reverse 0}))
        wildmenu-renderer (wilder.wildmenu_renderer {:highlighter [(wilder.pcre2_highlighter)
                                                                   (wilder.basic_highlighter)]
                                                     :left [" "
                                                            (wilder.wildmenu_spinner)
                                                            " "]
                                                     :right [" "
                                                             (wilder.wildmenu_index)]
                                                     :separator " · "})]
    (wilder.setup {:modes [":" "/" "?"]})
    (wilder.set_option :pipeline
                       [(wilder.branch (wilder.cmdline_pipeline)
                                       (wilder.search_pipeline))])
    (wilder.set_option :renderer
                       (wilder.renderer_mux {:/ popupmenu-renderer
                                             ":" palette-renderer
                                             :substitute wildmenu-renderer}))))

M

