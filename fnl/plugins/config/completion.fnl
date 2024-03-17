(local M {})

(fn M.setup []
  (let [cmp (require :cmp)
        cmp-autopairs (require :nvim-autopairs.completion.cmp)]
    (fn t [str] (vim.api.nvim_replace_termcodes str true true true))

    (fn has-words-before []
      (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
        (and (not= col 0) (= (: (: (. (vim.api.nvim_buf_get_lines 0 (- line 1)
                                                                  line true)
                                      1)
                                   :sub col col)
                                :match "%s") nil))))

    (fn feedkey [key mode]
      (vim.api.nvim_feedkeys (vim.api.nvim_replace_termcodes key true true true)
                             mode true))

    (cmp.event:on :confirm_done (cmp-autopairs.on_confirm_done))
    (local source-mapping {:buffer "[Buffer]"
                           :cmp_tabnine "[TN]"
                           :nvim_lsp "[LSP]"
                           :nvim_lua "[Lua]"
                           :path "[Path]"})
    (cmp.setup {:completion {:completeopt "menu,menuone,noselect"}
                :experimental {:ghost_text true}
                :formatting {:format (fn [entry vim-item]
                                       (set vim-item.kind
                                            ((. (require :lspkind) :symbolic) vim-item.kind
                                                                              {:mode :symbol}))
                                       (set vim-item.menu
                                            (. source-mapping entry.source.name))
                                       (when (= entry.source.name :cmp_tabnine)
                                         (local detail
                                                (. (or entry.completion_item.labelDetails
                                                       {})
                                                   :detail))
                                         (set vim-item.kind "")
                                         (when (and detail
                                                    (detail:find ".*%%.*"))
                                           (set vim-item.kind
                                                (.. vim-item.kind " " detail)))
                                         (when (. (or entry.completion_item.data
                                                      {})
                                                  :multiline)
                                           (set vim-item.kind
                                                (.. vim-item.kind " " "[ML]"))))
                                       (local maxwidth 80)
                                       (set vim-item.abbr
                                            (string.sub vim-item.abbr 1
                                                        maxwidth))
                                       vim-item)}
                :mapping {:<C-Esc> (cmp.mapping {:c (cmp.mapping.close)
                                                 :i (cmp.mapping.close)})
                          :<C-Space> (cmp.mapping (cmp.mapping.complete)
                                                  [:i :c])
                          :<C-b> (cmp.mapping (cmp.mapping.scroll_docs (- 3))
                                              [:i :c])
                          :<C-f> (cmp.mapping (cmp.mapping.scroll_docs 3)
                                              [:i :c])
                          :<C-n> (cmp.mapping {:c (fn []
                                                    (if (cmp.visible)
                                                        (cmp.select_next_item {:behavior cmp.SelectBehavior.Select})
                                                        (vim.api.nvim_feedkeys (t :<Down>)
                                                                               :n
                                                                               true)))
                                               :i (fn [fallback]
                                                    (if (cmp.visible)
                                                        (cmp.select_next_item {:behavior cmp.SelectBehavior.Select})
                                                        (fallback)))})
                          :<C-p> (cmp.mapping {:c (fn []
                                                    (if (cmp.visible)
                                                        (cmp.select_prev_item {:behavior cmp.SelectBehavior.Select})
                                                        (vim.api.nvim_feedkeys (t :<Up>)
                                                                               :n
                                                                               true)))
                                               :i (fn [fallback]
                                                    (if (cmp.visible)
                                                        (cmp.select_prev_item {:behavior cmp.SelectBehavior.Select})
                                                        (fallback)))})
                          :<CR> (cmp.mapping {:c (fn [fallback]
                                                   (if (cmp.visible)
                                                       (cmp.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                                     :select false})
                                                       (fallback)))
                                              :i (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                                       :select false})})
                          :<Down> (cmp.mapping (cmp.mapping.select_next_item {:behavior cmp.SelectBehavior.Select})
                                               [:i])
                          :<S-Tab> (cmp.mapping (fn []
                                                  (when (cmp.visible)
                                                    (cmp.select_prev_item)))
                                                [:i :s])
                          :<Tab> (cmp.mapping (fn [fallback]
                                                (if (cmp.visible)
                                                    (cmp.select_next_item)
                                                    (has-words-before)
                                                    (cmp.complete) (fallback)))
                                              [:i :s])
                          :<Up> (cmp.mapping (cmp.mapping.select_prev_item {:behavior cmp.SelectBehavior.Select})
                                             [:i])}
                :snippet {:expand (fn [args]
                                    ((. (require :luasnip) :lsp_expand) args.body))}
                :sources [{:name :cmp_tabnine}
                          {:name :luasnip}
                          {:name :nvim_lsp}
                          {:name :treesitter}
                          {:name :nvim_lsp_signature_help}
                          {:name :path}
                          {:keyworld_length 3 :name :npm}
                          {:name :nvim_lua}
                          {:name :calc}
                          {:name :spell}
                          {:name :emoji}]
                :view {:entries {:name :custom :selection_order :near_cursor}}})
    (cmp.setup.cmdline ":"
                       {:completion {:autocomplete {}}
                        :sources (cmp.config.sources [{:name :path}
                                                      {:name :cmdline}])})
    (cmp.setup.cmdline "/"
                       {:completion {:autocomplete {}}
                        :sources (cmp.config.sources [{:name :nvim_lsp_document_symbol}
                                                      {:name :buffer
                                                       :option {:keyword_pattern "[^[:blank:]].*"}}])})))

M

