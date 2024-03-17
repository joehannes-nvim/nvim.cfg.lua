; ### AstroNvim Status Components
;
; Statusline related component functions to use with Heirline
;
; This module can be loaded with `local component = require "astronvim.utils.status.component"`
;
; @module astronvim.utils.status.component
; @copyright 2023
; @license GNU General Public License v3.0

(local M {})
(local condition (require :utils.astro.status.condition))
(local env (require :utils.astro.status.env))
(local hl (require :utils.astro.status.hl))
(local init (require :utils.astro.status.init))
(local provider (require :utils.astro.status.provider))
(local status-utils (require :utils.astro.status.utils))
(local utils (require :utils.astro))
(local buffer-utils (require :utils.astro.buffer))
(local extend-tbl utils.extend_tbl)
(local get-icon utils.get_icon)
(local is-available utils.is_available)
(fn M.fill [opts]
  (extend-tbl {:provider (provider.fill)} opts))
(fn M.file_info [opts]
  (set-forcibly! opts (extend-tbl {:file_icon {:hl (hl.file_icon :statusline)
                                               :padding {:left 1 :right 1}}
                                   :file_modified {:padding {:left 1}}
                                   :file_read_only {:padding {:left 1}}
                                   :filename {}
                                   :hl (hl.get_attributes :file_info)
                                   :surround {:color :file_info_bg
                                              :condition condition.has_filetype
                                              :separator :left}}
                                  opts))
  (M.builder (status-utils.setup_providers opts
                                           [:file_icon
                                            :unique_path
                                            :filename
                                            :filetype
                                            :file_modified
                                            :file_read_only
                                            :close_button])))
(fn M.tabline_file_info [opts]
  (M.file_info (extend-tbl {:close_button {:hl (fn [self]
                                                 (hl.get_attributes (.. self.tab_type
                                                                        :_close)))
                                           :on_click {:callback (fn [_ minwid]
                                                                  (buffer-utils.close minwid))
                                                      :minwid (fn [self]
                                                                self.bufnr)
                                                      :name :heirline_tabline_close_buffer_callback}
                                           :padding {:left 1 :right 1}}
                            :file_icon {:condition (fn [self]
                                                     (not self._show_picker))
                                        :hl (hl.file_icon :tabline)}
                            :hl (fn [self]
                                  (var tab-type self.tab_type)
                                  (when (and self._show_picker
                                             (not= self.tab_type :buffer_active))
                                    (set tab-type :buffer_visible))
                                  (hl.get_attributes tab-type))
                            :padding {:left 1 :right 1}
                            :surround false
                            :unique_path {:hl (fn [self]
                                                (hl.get_attributes (.. self.tab_type
                                                                       :_path)))}}
                           opts)))
(fn M.nav [opts]
  (set-forcibly! opts (extend-tbl {:hl (hl.get_attributes :nav)
                                   :percentage {:padding {:left 1}}
                                   :ruler {}
                                   :scrollbar {:hl {:fg :scrollbar}
                                               :padding {:left 1}}
                                   :surround {:color :nav_bg :separator :right}
                                   :update [:CursorMoved
                                            :CursorMovedI
                                            :BufEnter]}
                                  opts))
  (M.builder (status-utils.setup_providers opts [:ruler :percentage :scrollbar])))
(fn M.cmd_info [opts]
  (set-forcibly! opts (extend-tbl {:condition (fn []
                                                (= (vim.opt.cmdheight:get) 0))
                                   :hl (hl.get_attributes :cmd_info)
                                   :macro_recording {:condition condition.is_macro_recording
                                                     :icon {:kind :MacroRecording
                                                            :padding {:right 1}}
                                                     :update {1 :RecordingEnter
                                                              2 :RecordingLeave
                                                              :callback (or (and (= (vim.fn.has :nvim-0.9)
                                                                                    0)
                                                                                 (vim.schedule_wrap (fn []
                                                                                                      (vim.cmd.redrawstatus))))
                                                                            nil)}}
                                   :search_count {:condition condition.is_hlsearch
                                                  :icon {:kind :Search
                                                         :padding {:right 1}}
                                                  :padding {:left 1}}
                                   :showcmd {:condition condition.is_statusline_showcmd
                                             :padding {:left 1}}
                                   :surround {:color :cmd_info_bg
                                              :condition (fn []
                                                           (or (or (condition.is_hlsearch)
                                                                   (condition.is_macro_recording))
                                                               (condition.is_statusline_showcmd)))
                                              :separator :center}}
                                  opts))
  (M.builder (status-utils.setup_providers opts
                                           [:macro_recording
                                            :search_count
                                            :showcmd])))
(fn M.mode [opts]
  (set-forcibly! opts (extend-tbl {:hl (hl.get_attributes :mode)
                                   :mode_text false
                                   :paste false
                                   :spell false
                                   :surround {:color hl.mode_bg
                                              :separator :left}
                                   :update {1 :ModeChanged
                                            :callback (vim.schedule_wrap (fn []
                                                                           (vim.cmd.redrawstatus)))
                                            :pattern "*:*"}}
                                  opts))
  (when (not (. opts :mode_text)) (set opts.str {:str " "}))
  (M.builder (status-utils.setup_providers opts [:mode_text :str :paste :spell])))
(fn M.breadcrumbs [opts]
  (set-forcibly! opts (extend-tbl {:condition condition.aerial_available
                                   :padding {:left 1}
                                   :update :CursorMoved}
                                  opts))
  (set opts.init (init.breadcrumbs opts))
  opts)
(fn M.separated_path [opts]
  (set-forcibly! opts (extend-tbl {:padding {:left 1}
                                   :update [:BufEnter :DirChanged]}
                                  opts))
  (set opts.init (init.separated_path opts))
  opts)
(fn M.git_branch [opts]
  (set-forcibly! opts (extend-tbl {:git_branch {:icon {:kind :GitBranch
                                                       :padding {:right 1}}}
                                   :hl (hl.get_attributes :git_branch)
                                   :init (init.update_events [:BufEnter])
                                   :on_click {:callback (fn []
                                                          (when (is-available :telescope.nvim)
                                                            (vim.defer_fn (fn []
                                                                            ((. (require :telescope.builtin)
                                                                                :git_branches) {:use_file_path true}))
                                                              100)))
                                              :name :heirline_branch}
                                   :surround {:color :git_branch_bg
                                              :condition condition.is_git_repo
                                              :separator :left}
                                   :update {1 :User :pattern :GitSignsUpdate}}
                                  opts))
  (M.builder (status-utils.setup_providers opts [:git_branch])))
(fn M.git_diff [opts]
  (set-forcibly! opts (extend-tbl {:added {:icon {:kind :GitAdd
                                                  :padding {:left 1 :right 1}}}
                                   :changed {:icon {:kind :GitChange
                                                    :padding {:left 1 :right 1}}}
                                   :hl (hl.get_attributes :git_diff)
                                   :init (init.update_events [:BufEnter])
                                   :on_click {:callback (fn []
                                                          (when (is-available :telescope.nvim)
                                                            (vim.defer_fn (fn []
                                                                            ((. (require :telescope.builtin)
                                                                                :git_status) {:use_file_path true}))
                                                              100)))
                                              :name :heirline_git}
                                   :removed {:icon {:kind :GitDelete
                                                    :padding {:left 1 :right 1}}}
                                   :surround {:color :git_diff_bg
                                              :condition condition.git_changed
                                              :separator :left}
                                   :update {1 :User :pattern :GitSignsUpdate}}
                                  opts))
  (M.builder (status-utils.setup_providers opts [:added :changed :removed]
                                           (fn [p-opts p]
                                             (let [out (status-utils.build_provider p-opts
                                                                                    p)]
                                               (when out
                                                 (set out.provider :git_diff)
                                                 (set out.opts.type p)
                                                 (when (= out.hl nil)
                                                   (set out.hl
                                                        {:fg (.. :git_ p)})))
                                               out)))))
(fn M.diagnostics [opts]
  (set-forcibly! opts (extend-tbl {:ERROR {:icon {:kind :DiagnosticError
                                                  :padding {:left 1 :right 1}}}
                                   :HINT {:icon {:kind :DiagnosticHint
                                                 :padding {:left 1 :right 1}}}
                                   :INFO {:icon {:kind :DiagnosticInfo
                                                 :padding {:left 1 :right 1}}}
                                   :WARN {:icon {:kind :DiagnosticWarn
                                                 :padding {:left 1 :right 1}}}
                                   :hl (hl.get_attributes :diagnostics)
                                   :on_click {:callback (fn []
                                                          (when (is-available :telescope.nvim)
                                                            (vim.defer_fn (fn []
                                                                            ((. (require :telescope.builtin)
                                                                                :diagnostics)))
                                                              100)))
                                              :name :heirline_diagnostic}
                                   :surround {:color :diagnostics_bg
                                              :condition condition.has_diagnostics
                                              :separator :left}
                                   :update [:DiagnosticChanged :BufEnter]}
                                  opts))
  (M.builder (status-utils.setup_providers opts [:ERROR :WARN :INFO :HINT]
                                           (fn [p-opts p]
                                             (let [out (status-utils.build_provider p-opts
                                                                                    p)]
                                               (when out
                                                 (set out.provider :diagnostics)
                                                 (set out.opts.severity p)
                                                 (when (= out.hl nil)
                                                   (set out.hl
                                                        {:fg (.. :diag_ p)})))
                                               out)))))
(fn M.treesitter [opts]
  (set-forcibly! opts (extend-tbl {:hl (hl.get_attributes :treesitter)
                                   :init (init.update_events [:BufEnter])
                                   :str {:icon {:kind :ActiveTS
                                                :padding {:right 1}}
                                         :str :TS}
                                   :surround {:color :treesitter_bg
                                              :condition condition.treesitter_available
                                              :separator :right}
                                   :update {1 :OptionSet :pattern :syntax}}
                                  opts))
  (M.builder (status-utils.setup_providers opts [:str])))
(fn M.lsp [opts]
  (set-forcibly! opts (extend-tbl {:hl (hl.get_attributes :lsp)
                                   :lsp_client_names {:icon {:kind :ActiveLSP
                                                             :padding {:right 2}}
                                                      :str :LSP
                                                      :update {1 :LspAttach
                                                               2 :LspDetach
                                                               3 :BufEnter
                                                               :callback (vim.schedule_wrap (fn []
                                                                                              (vim.cmd.redrawstatus)))}}
                                   :lsp_progress {:padding {:right 1}
                                                  :str ""
                                                  :update {1 :User
                                                           :callback (vim.schedule_wrap (fn []
                                                                                          (vim.cmd.redrawstatus)))
                                                           :pattern :AstroLspProgress}}
                                   :on_click {:callback (fn []
                                                          (vim.defer_fn (fn []
                                                                          (vim.cmd.LspInfo))
                                                            100))
                                              :name :heirline_lsp}
                                   :surround {:color :lsp_bg
                                              :condition condition.lsp_attached
                                              :separator :right}}
                                  opts))
  (M.builder (status-utils.setup_providers opts
                                           [:lsp_progress :lsp_client_names]
                                           (fn [p-opts p i]
                                             (or (and p-opts
                                                      {1 (status-utils.build_provider p-opts
                                                                                      ((. provider
                                                                                          p) p-opts))
                                                       2 (status-utils.build_provider p-opts
                                                                                      (provider.str p-opts))
                                                       :flexible i})
                                                 false)))))
(fn M.foldcolumn [opts]
  (set-forcibly! opts (extend-tbl {:condition condition.foldcolumn_enabled
                                   :foldcolumn {:padding {:right 1}}
                                   :on_click {:callback (fn [...]
                                                          (local char
                                                                 (. (status-utils.statuscolumn_clickargs ...)
                                                                    :char))
                                                          (local fillchars
                                                                 (vim.opt_local.fillchars:get))
                                                          (if (= char
                                                                 (or fillchars.foldopen
                                                                     (get-icon :FoldOpened)))
                                                              (vim.cmd "norm! zc")
                                                              (= char
                                                                 (or fillchars.foldclose
                                                                     (get-icon :FoldClosed)))
                                                              (vim.cmd "norm! zo")))
                                              :name :fold_click}}
                                  opts))
  (M.builder (status-utils.setup_providers opts [:foldcolumn])))
(fn M.numbercolumn [opts]
  (set-forcibly! opts (extend-tbl {:condition condition.numbercolumn_enabled
                                   :numbercolumn {:padding {:right 1}}
                                   :on_click {:callback (fn [...]
                                                          (local args
                                                                 (status-utils.statuscolumn_clickargs ...))
                                                          (when (args.mods:find :c)
                                                            (local (dap-avail dap)
                                                                   (pcall require
                                                                          :dap))
                                                            (when dap-avail
                                                              (vim.schedule dap.toggle_breakpoint))))
                                              :name :line_click}}
                                  opts))
  (M.builder (status-utils.setup_providers opts [:numbercolumn])))
(fn M.signcolumn [opts]
  (set-forcibly! opts (extend-tbl {:condition condition.signcolumn_enabled
                                   :on_click {:callback (fn [...]
                                                          (local args
                                                                 (status-utils.statuscolumn_clickargs ...))
                                                          (when (and (and args.sign
                                                                          args.sign.name)
                                                                     (. env.sign_handlers
                                                                        args.sign.name))
                                                            ((. env.sign_handlers
                                                                args.sign.name) args)))
                                              :name :sign_click}
                                   :signcolumn {}}
                                  opts))
  (M.builder (status-utils.setup_providers opts [:signcolumn])))
(fn M.builder [opts]
  (set-forcibly! opts (extend-tbl {:padding {:left 0 :right 0}} opts))
  (local children {})
  (when (> opts.padding.left 0)
    (table.insert children
                  {:provider (status-utils.pad_string " "
                                                      {:left (- opts.padding.left
                                                                1)})}))
  (each [key entry (pairs opts)]
    (when (and (and (and (= (type key) :number) (= (type entry) :table))
                    (. provider entry.provider))
               (or (= entry.opts nil) (= (type entry.opts) :table)))
      (set entry.provider ((. provider entry.provider) entry.opts)))
    (tset children key entry))
  (when (> opts.padding.right 0)
    (table.insert children
                  {:provider (status-utils.pad_string " "
                                                      {:right (- opts.padding.right
                                                                 1)})}))
  (or (and opts.surround
           (status-utils.surround opts.surround.separator opts.surround.color
                                  children opts.surround.condition))
      children))
M
