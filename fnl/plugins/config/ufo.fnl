(local M {})

(fn M.setup []
  (set vim.o.fillchars "eob: ,fold: ,foldopen:,foldsep:│,foldclose:")
  ((. (require :ufo) :setup) {:enable_get_fold_virt_text true
                              :fold_virt_text_handler (fn [virt-text
                                                           lnum
                                                           end-lnum
                                                           width
                                                           truncate]
                                                        (local new-virt-text {})
                                                        (var suffix
                                                             (: "  %d "
                                                                :format
                                                                (- end-lnum
                                                                   lnum)))
                                                        (local suf-width
                                                               (vim.fn.strdisplaywidth suffix))
                                                        (local target-width
                                                               (- width
                                                                  suf-width))
                                                        (var cur-width 0)
                                                        (each [_ chunk (ipairs virt-text)]
                                                          (var chunk-text
                                                               (. chunk 1))
                                                          (var chunk-width
                                                               (vim.fn.strdisplaywidth chunk-text))
                                                          (if (> target-width
                                                                 (+ cur-width
                                                                    chunk-width))
                                                              (table.insert new-virt-text
                                                                            chunk)
                                                              (do
                                                                (set chunk-text
                                                                     (truncate chunk-text
                                                                               (- target-width
                                                                                  cur-width)))
                                                                (local hl-group
                                                                       (. chunk
                                                                          2))
                                                                (table.insert new-virt-text
                                                                              [chunk-text
                                                                               hl-group])
                                                                (set chunk-width
                                                                     (vim.fn.strdisplaywidth chunk-text))
                                                                (when (< (+ cur-width
                                                                            chunk-width)
                                                                         target-width)
                                                                  (set suffix
                                                                       (.. suffix
                                                                           (: " "
                                                                              :rep
                                                                              (- (- target-width
                                                                                    cur-width)
                                                                                 chunk-width)))))
                                                                (lua :break)))
                                                          (set cur-width
                                                               (+ cur-width
                                                                  chunk-width)))
                                                        (table.insert new-virt-text
                                                                      [suffix
                                                                       :MoreMsg])
                                                        new-virt-text)
                              :open_fold_hl_timeout 150
                              :preview {:mappings {:scrollD :<C-d>
                                                   :scrollU :<C-u>}
                                        :win_config {:border [""
                                                              "─"
                                                              ""
                                                              ""
                                                              ""
                                                              "─"
                                                              ""
                                                              ""]
                                                     :winblend 0
                                                     :winhighlight "Normal:Folded"}}
                              :provider_selector (fn [bufnr filetype buftype]
                                                   [:treesitter :indent])}))

M

