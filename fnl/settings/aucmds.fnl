(local M {:MyBootAugroup {[:VimEnter] {:callback (fn []
                                                   (my.fn.onAfterBoot)
                                                   (vim.schedule (fn [] (vim.cmd :SessionLoad))))
                                       :pattern "*"}}
          :MyModeAugroup {[:ModeChanged] {:callback (fn [] (my.fn.onModeChanged))
                                          :pattern "*:*"}}
          :MyColorAugroup {[:ColorScheme] {:callback (fn [] (my.fn.onColorScheme))
                                           :pattern "*"}}
          :MyCursorAugroup {[:WinEnter :BufWinEnter] {:callback (fn []
                                                                  (vim.cmd "setlocal cursorline cursorcolumn"))
                                                      :pattern "*"}
                            [:WinLeave] {:callback (fn []
                                                      (vim.cmd "setlocal nocursorline nocursorcolumn"))
                                         :pattern "*"}
                            [:BufEnter :BufWinEnter :InsertLeave :FocusGained] {:callback (fn [_opts]
                                                                                            (vim.api.nvim_set_option_value :relativenumber
                                                                                                                           true
                                                                                                                           {:scope :local}))
                                                                                :pattern "*.*"}
                            [:BufLeave :BufWinLeave :InsertEnter :FocusLost] {:callback (fn [_opts]
                                                                                          (vim.api.nvim_set_option_value :relativenumber
                                                                                                                         false
                                                                                                                         {:scope :local}))
                                                                              :pattern "*.*"}}
          :MyFoldsAugroup {[:BufWinEnter] [{:callback (fn [args]
                                                        (when (not (. (. vim.b args.buf)
                                                                      :view_activated))
                                                          (local filetype
                                                                  (vim.api.nvim_get_option_value :filetype
                                                                                                {:buf args.buf}))
                                                          (local buftype
                                                                  (vim.api.nvim_get_option_value :buftype
                                                                                                {:buf args.buf}))
                                                          (local ignore-filetypes
                                                                  [:gitcommit
                                                                   :gitrebase
                                                                   :svg
                                                                   :hgcommit])
                                                          (when (and (and (and (= buftype "")
                                                                               filetype)
                                                                          (not= filetype "")
                                                                      (not (vim.tbl_contains ignore-filetypes filetype))))
                                                            (tset (. vim.b args.buf) :view_activated
                                                                  true)
                                                            (vim.cmd.loadview {:mods {:emsg_silent true}}))))
                                            :pattern "*"}]
                           [:BufWinLeave :BufWritePost :WinLeave] [{:callback (fn [args]
                                                                                (when (. (. vim.b args.buf) :view_activated)
                                                                                  (vim.cmd.mkview {:mods {:emsg_silent true}})))
                                                                    :pattern "*.*"}]}
          :MyHighlightAugroup {[:TextYankPost] {:callback (fn []
                                                            (vim.highlight.on_yank {:higroup :IncSearch
                                                                                    :hlgroup :IncSearch
                                                                                    :timeout 2000}))
                                                :pattern "*"}}
          :MyListsAugroup {[:BufEnter :BufWinEnter :FocusGained] {:callback #(vim.cmd "setlocal nonumber norelativenumber foldcolumn=0 nocursorcolumn")
                                                                  :pattern [:qf :trouble :help]}
                           [:QuickFixCmdPost] {:callback #(vim.cmd.normal :cwindow)
                                               :pattern "*grep*"}}
          :MyReadAugroup {[:BufNewFile :BufRead] [{:callback (fn []
                                                               (vim.cmd "setlocal spell"))
                                                   :pattern [:*.md :*.org :*.wiki :*.dict :*.txt]}
                                                  {:callback (fn []
                                                               (vim.cmd "setfiletype markdown"))
                                                   :pattern [:*.org :*.wiki]}
                                                  {:callback (fn []
                                                               (vim.cmd "setfiletype clojure"))
                                                   :pattern [:*.cljd :*.cljs]}]}
          :MyTerminalAugroup {[:TermOpen :TermEnter] {:callback #(vim.cmd "setlocal nonumber norelativenumber foldcolumn=0 nocursorline")
                                                      :pattern "*"}}
          :MyWriteAugroup {[:BufWritePre] {:callback (fn [])
                                           :pattern [:*.clj :*.cljc :*.cljs]}}
          :PersistedHooks {[:User] [{:callback (fn [] (vim.cmd :ScopeLoadState))
                                     :pattern :PersistedLoadPre}
                                    {:callback (fn [])
                                     :pattern :PersistedTelescopeLoadPre}
                                    {:callback (fn []
                                                 (vim.schedule (fn [])))
                                     :pattern :PersistedLoadPost}
                                    {:callback (fn [])
                                     :pattern :PersistedTelescopeLoadPost}
                                    {:callback (fn [] (vim.cmd :ScopeSaveState))
                                     :pattern :PersistedSavePre}]}})

M
