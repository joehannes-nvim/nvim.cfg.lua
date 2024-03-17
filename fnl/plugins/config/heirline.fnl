(local dropbar _G.dropbar)
(local conditions (require :heirline.conditions))

(local utils (require :heirline.utils))

(fn vimode-color []
  (or (. my.color.my.vimode (or (vim.fn.mode) :n)) (. my.color.my.vimode :n)))

(fn setup-colors []
  (let [dark-mode (= (vim.opt.background:get) :dark)]
    {:aqua my.color.my.theme.bold-retro.normal
     :blue my.color.my.blue
     :current_bg (or (and dark-mode my.color.my.dark) my.color.my.light)
     :current_fg (or (and dark-mode my.color.my.light) my.color.my.dark)
     :dark my.color.my.dark
     :diag_error my.color.my.theme.bold-retro.attention
     :diag_hint my.color.my.theme.bold-retro.secondary
     :diag_info my.color.my.theme.bold-retro.normal
     :diag_warn my.color.my.orange
     :git_add my.color.my.theme.bold-retro.flow
     :git_change my.color.my.theme.bold-retro.secondary
     :git_del my.color.my.theme.bold-retro.attention
     :gray (. (utils.get_highlight :NonText) :fg)
     :green my.color.my.theme.bold-retro.flow
     :light my.color.my.light
     :magenta my.color.my.theme.bold-retro.primary
     :orange my.color.my.orange
     :purple my.color.my.theme.bold-retro.command
     :red my.color.my.theme.bold-retro.attention
     :vimode (vimode-color)
     :yellow my.color.my.theme.bold-retro.secondary}))

(local Arrow-left-left {:hl (fn [self]
                              {:bg (vimode-color) :fg my.color.my.theme.bold-retro.primary})
                        :provider ""})

(local Arrow-right-left {1 Arrow-left-left
                         :hl (fn [self]
                               {:bg my.color.my.theme.bold-retro.primary
                                :fg (vimode-color)
                                :force true})})

(local Arrow-right-right {:hl {:bg :vimode :fg my.color.my.theme.bold-retro.primary}
                          :provider ""})

(local Arrow-left-right {1 Arrow-right-right
                         :hl (fn [self]
                               {:bg my.color.my.theme.bold-retro.primary
                                :fg (vimode-color)
                                :force true})})

(local Slant-right-right {:hl {:bg :vimode :fg :magenta} :provider ""})

(local Slant-right-left {:hl {:bg :magenta :fg :vimode} :provider ""})

(local Slant-left-left {:hl {:bg :vimode :fg :magenta} :provider ""})

(local Slant-left-right {:hl {:bg :magenta :fg :vimode} :provider ""})

(local Space {:provider " "})

(local Vi-mode {:hl (fn [self] {:bg :magenta :bold true :fg :dark})
                :init (fn [self] (set self.mode (vim.fn.mode)))
                :provider (fn [self] (. self.mode_names self.mode))
                :static {:mode_names {"\019" :^S
                                      "\022" :^V
                                      "\022s" :^V
                                      :! "!"
                                      :R :R
                                      :Rc :Rc
                                      :Rv :Rv
                                      :Rvc :Rv
                                      :Rvx :Rv
                                      :Rx :Rx
                                      :S :S_
                                      :V :V_
                                      :Vs :Vs
                                      :c :C
                                      :cv :Ex
                                      :i :I
                                      :ic :Ic
                                      :ix :Ix
                                      :n :N
                                      :niI :Ni
                                      :niR :Nr
                                      :niV :Nv
                                      :no :N?
                                      "no\022" :N?
                                      :noV :N?
                                      :nov :N?
                                      :nt :Nt
                                      :r "..."
                                      :r? "?"
                                      :rm :M
                                      :s :S
                                      :t :T
                                      :v :V
                                      :vs :Vs}}})

(var File-name-block
     {:init (fn [self] (set self.filename (vim.api.nvim_buf_get_name 0)))})

(local File-icon-bare
       {:init (fn [self]
                (local filename self.filename)
                (local extension (vim.fn.fnamemodify filename ":e"))
                (set (self.icon self.icon_color)
                     ((. (require :nvim-web-devicons) :get_icon_color) filename
                                                                       extension
                                                                       {:default true})))
        :provider (fn [self] (and self.icon (.. self.icon " ")))})

(global File-icon {1 {:hl {:bg :magenta :fg :dark}}})

(local File-name
       {1 {:hl {:bg :magenta :fg :dark} :provider (fn [self] self.lfilename)}
        :init (fn [self]
                (set self.lfilename (vim.fn.fnamemodify self.filename ":."))
                (set self.shortened false)
                (when (= self.lfilename "") (set self.lfilename "[No Name]"))
                (when (not (conditions.width_percent_below (length self.lfilename)
                                                           0.27))
                  (set self.lfilename (vim.fn.pathshorten self.lfilename))
                  (set self.shortened true)))
        :on_click {:callback (fn []
                               ((. (require :ranger-nvim) :open) true))
                   :name :heirline_filename_ranger_current}})

(local File-flags [{:hl {:fg :green}
                    :provider (fn [] (when vim.bo.modified " [+]"))}
                   {:hl {:fg :red}
                    :provider (fn []
                                (when (or (not vim.bo.modifiable)
                                          vim.bo.readonly)
                                  " "))}])

(local File-name-modifer
       {:hl (fn []
              (when vim.bo.modified
                {:bold true :fg my.color.my.theme.bold-retro.normal :force true}))})

(set File-name-block (utils.insert File-name-block {:provider " "} File-icon
                                   (utils.insert File-name-modifer File-name)
                                   (unpack File-flags)))

(local File-type
       {:hl {:fg :dark} :provider (fn [] (string.upper vim.bo.filetype))})

(local File-encoding
       {:provider (fn []
                    (local enc (or (and (not= vim.bo.fenc "") vim.bo.fenc)
                                   vim.o.enc))
                    (and (not= enc :utf-8) (enc:upper)))})

(local File-format
       {:provider (fn [] (local fmt vim.bo.fileformat)
                    (and (not= fmt :unix) (fmt:upper)))})

(local File-size {:provider (fn []
                              (local suffix [:b :k :M :G :T :P :E])
                              (var fsize
                                   (vim.fn.getfsize (vim.api.nvim_buf_get_name 0)))
                              (set fsize (or (and (< fsize 0) 0) fsize))
                              (when (<= fsize 0)
                                (let [___antifnl_rtn_1___ (.. :0 (. suffix 1))]
                                  (lua "return ___antifnl_rtn_1___")))
                              (local i
                                     (math.floor (/ (math.log fsize)
                                                    (math.log 1024))))
                              (string.format "%.2g%s"
                                             (/ fsize (math.pow 1024 i))
                                             (. suffix i)))})

(local File-last-modified
       {:provider (fn []
                    (local ftime
                           (vim.fn.getftime (vim.api.nvim_buf_get_name 0)))
                    (and (> ftime 0) (os.date "%c" ftime)))})

(local Ruler {:provider "%7(%l/%3L%):%2c %P"})

(local Scroll-bar {:hl {:bg :current_bg :fg :magenta}
                   :provider (fn [self]
                               (local curr-line
                                      (. (vim.api.nvim_win_get_cursor 0) 1))
                               (local lines (vim.api.nvim_buf_line_count 0))
                               (local i
                                      (+ (math.floor (* (/ curr-line lines)
                                                        (- (length self.sbar) 1)))
                                         1))
                               (string.rep (. self.sbar i) 2))
                   :static {:sbar ["▁"
                                   "▂"
                                   "▃"
                                   "▄"
                                   "▅"
                                   "▆"
                                   "▇"
                                   "█"]}})

(local LSPActive {:condition conditions.lsp_attached
                  :hl {:bg :magenta :bold true :fg :green}
                  :on_click {:callback (fn []
                                         (vim.defer_fn (fn []
                                                         (vim.cmd :LspInfo))
                                           100))
                             :name :heirline_LSP}
                  :provider " LSP"
                  :update [:LspAttach :LspDetach]})

(local Dropbar
       {:condition (fn [self]
                     (set self.data
                          (vim.tbl_get (or dropbar.bars {})
                                       (vim.api.nvim_get_current_buf)
                                       (vim.api.nvim_get_current_win)))
                     self.data)
        :hl {:bg my.color.my.theme.bold-retro.primary :fg my.color.my.dark :force true}
        :init (fn [self]
                (local components self.data.components)
                (local children {})
                (each [i c (ipairs components)]
                  (local child
                         {1 {:hl c.icon_hl :provider c.icon}
                          2 {:hl c.name_hl :provider c.name}
                          :on_click {:callback (self.dropbar_on_click_string:format self.data.buf
                                                                                    self.data.win
                                                                                    i)
                                     :name :heirline_dropbar}})
                  (when (< i (length components))
                    (local sep self.data.separator)
                    (table.insert child
                                  {:hl sep.icon_hl
                                   :on_click {:callback (self.dropbar_on_click_string:format self.data.buf
                                                                                             self.data.win
                                                                                             (+ i
                                                                                                1))}
                                   :provider sep.icon}))
                  (table.insert children child))
                (set self.child (self:new children 1)))
        :provider (fn [self] (self.child:eval))
        :static {:dropbar_on_click_string "v:lua.dropbar.on_click_callbacks.buf%s.win%s.fn%s"}})

(local Navic {:condition (fn [self]
                           ((. (require :nvim-navic) :is_available) (vim.api.nvim_get_current_buf)))
              :hl {:fg my.color.my.dark}
              :init (fn [self]
                      (local data (or ((. (require :nvim-navic) :get_data)) {}))
                      (local children {})
                      (each [i d (ipairs data)]
                        (local pos
                               (self.enc d.scope.start.line
                                         d.scope.start.character self.winnr))
                        (local child
                               [{:hl (. self.type_hl d.type) :provider d.icon}
                                {:on_click {:callback (fn [_ minwid]
                                                        (local (line col winnr)
                                                               (self.dec minwid))
                                                        (vim.api.nvim_win_set_cursor (vim.fn.win_getid winnr)
                                                                                     [line
                                                                                      col]))
                                            :minwid pos
                                            :name :heirline_navic}
                                 :provider (: (d.name:gsub "%%" "%%%%") :gsub
                                              "%s*->%s*" "")}])
                        (when (and (> (length data) 1) (< i (length data)))
                          (table.insert child {:provider " > "}))
                        (table.insert children child))
                      (set self.child (self:new children 1)))
              :provider (fn [self] (self.child:eval))
              :static {:dec (fn [c]
                              (local line (bit.rshift c 16))
                              (local col (bit.band (bit.rshift c 6) 1023))
                              (local winnr (bit.band c 63))
                              (values line col winnr))
                       :enc (fn [line col winnr]
                              (bit.bor (bit.lshift line 16) (bit.lshift col 6)
                                       winnr))
                       :type_hl {:Array "@field"
                                 :Boolean "@boolean"
                                 :Class "@structure"
                                 :Constant "@constant"
                                 :Constructor "@constructor"
                                 :Enum "@field"
                                 :EnumMember "@field"
                                 :Event "@keyword"
                                 :Field "@field"
                                 :File :Directory
                                 :Function "@function"
                                 :Interface "@type"
                                 :Key "@keyword"
                                 :Method "@method"
                                 :Module "@include"
                                 :Namespace "@namespace"
                                 :Null "@comment"
                                 :Number "@number"
                                 :Object "@type"
                                 :Operator "@operator"
                                 :Package "@include"
                                 :Property "@property"
                                 :String "@string"
                                 :Struct "@structure"
                                 :TypeParameter "@type"
                                 :Variable "@variable"}}
              :update [:CursorMoved :ModeChanged]})

(local Buffer-local-diagnostics
       {1 {:provider (fn [self]
                      (and (> self.errors 0)
                          (.. (or self.error_icon "  ") self.errors " ")))}
        2 {:provider (fn [self]
                      (and (> self.warnings 0)
                        (.. (or self.warn_icon "  ") self.warnings " ")))}
        3 {:provider (fn [self]
                      (and (> self.info 0)
                        (.. (or self.info_icon "  ") self.info " ")))}
        4 {:provider (fn [self]
                      (and (> self.hints 0)
                          (.. (or self.hint_icon " ☉ ") self.hints)))}
        :condition conditions.has_diagnostics
        :init (fn [self]
                (set self.errors
                     (length (vim.diagnostic.get 0
                                                 {:severity vim.diagnostic.severity.ERROR})))
                (set self.warnings
                     (length (vim.diagnostic.get 0
                                                 {:severity vim.diagnostic.severity.WARN})))
                (set self.hints
                     (length (vim.diagnostic.get 0
                                                 {:severity vim.diagnostic.severity.HINT})))
                (set self.info
                     (length (vim.diagnostic.get 0
                                                 {:severity vim.diagnostic.severity.INFO}))))
        :on_click {:callback (fn []
                               (vim.cmd "TroubleToggle document_diagnostics"))
                   :name :heirline_diagnostics}
        :static {:error_icon (. (vim.fn.sign_getdefined :DiagnosticSignError)
                                :text)
                 :hint_icon (. (vim.fn.sign_getdefined :DiagnosticSignHint)
                               :text)
                 :info_icon (. (vim.fn.sign_getdefined :DiagnosticSignInfo)
                               :text)
                 :warn_icon (. (vim.fn.sign_getdefined :DiagnosticSignWarn)
                               :text)}
        :update [:DiagnosticChanged :BufEnter :BufWinEnter]})

(local Buffer-diagnostics
       {1 {:hl {:fg (my.color.util.darken my.color.my.theme.bold-retro.attention 33)}
           :provider (fn [self]
                       (and (> self.errors 0)
                            (.. (or self.error_icon "  ") self.errors " ")))}
        2 {:hl {:fg (my.color.util.darken my.color.my.orange 33)}
           :provider (fn [self]
                       (and (> self.warnings 0)
                            (.. (or self.warn_icon "  ") self.warnings " ")))}
        3 {:hl {:fg (my.color.util.darken my.color.my.theme.bold-retro.normal 33)}
           :provider (fn [self]
                       (and (> self.info 0)
                            (.. (or self.info_icon "  ") self.info " ")))}
        4 {:hl {:fg (my.color.util.darken my.color.my.theme.bold-retro.flow 33)}
           :provider (fn [self]
                       (and (> self.hints 0)
                            (.. (or self.hint_icon " ☉ ") self.hints)))}
        :condition conditions.has_diagnostics
        :init (fn [self]
                (set self.errors
                     (length (vim.diagnostic.get 0
                                                 {:severity vim.diagnostic.severity.ERROR})))
                (set self.warnings
                     (length (vim.diagnostic.get 0
                                                 {:severity vim.diagnostic.severity.WARN})))
                (set self.hints
                     (length (vim.diagnostic.get 0
                                                 {:severity vim.diagnostic.severity.HINT})))
                (set self.info
                     (length (vim.diagnostic.get 0
                                                 {:severity vim.diagnostic.severity.INFO}))))
        :on_click {:callback (fn []
                               (vim.cmd "TroubleToggle workspace_diagnostics"))
                   :name :heirline_diagnostics}
        :static {:error_icon (. (vim.fn.sign_getdefined :DiagnosticSignError)
                                :text)
                 :hint_icon (. (vim.fn.sign_getdefined :DiagnosticSignHint)
                               :text)
                 :info_icon (. (vim.fn.sign_getdefined :DiagnosticSignInfo)
                               :text)
                 :warn_icon (. (vim.fn.sign_getdefined :DiagnosticSignWarn)
                               :text)}
        :update [:DiagnosticChanged :BufWinEnter :BufEnter]})

(local Diagnostics {1 {:hl {:fg (my.color.util.darken my.color.my.theme.bold-retro.attention 33)}
                       :provider (fn [self]
                                   (and (> self.errors 0)
                                        (.. (or self.error_icon "  ")
                                            self.errors " ")))}
                    2 {:hl {:fg (my.color.util.darken my.color.my.orange 33)}
                       :provider (fn [self]
                                   (and (> self.warnings 0)
                                        (.. (or self.warn_icon "  ")
                                            self.warnings " ")))}
                    3 {:hl {:fg (my.color.util.darken my.color.my.theme.bold-retro.normal 33)}
                       :provider (fn [self]
                                   (and (> self.info 0)
                                        (.. (or self.info_icon "  ") self.info
                                            " ")))}
                    4 {:hl {:fg (my.color.util.darken my.color.my.theme.bold-retro.flow 33)}
                       :provider (fn [self]
                                   (and (> self.hints 0)
                                        (.. (or self.hint_icon " ☉ ")
                                            self.hints)))}
                    :condition conditions.has_diagnostics
                    :init (fn [self]
                            (set self.errors
                                 (length (vim.diagnostic.get nil
                                                             {:severity vim.diagnostic.severity.ERROR})))
                            (set self.warnings
                                 (length (vim.diagnostic.get nil
                                                             {:severity vim.diagnostic.severity.WARN})))
                            (set self.hints
                                 (length (vim.diagnostic.get nil
                                                             {:severity vim.diagnostic.severity.HINT})))
                            (set self.info
                                 (length (vim.diagnostic.get nil
                                                             {:severity vim.diagnostic.severity.INFO}))))
                    :on_click {:callback (fn []
                                           (vim.cmd "TroubleToggle workspace_diagnostics"))
                               :name :heirline_diagnostics}
                    :static {:error_icon (. (vim.fn.sign_getdefined :DiagnosticSignError)
                                            :text)
                             :hint_icon (. (vim.fn.sign_getdefined :DiagnosticSignHint)
                                           :text)
                             :info_icon (. (vim.fn.sign_getdefined :DiagnosticSignInfo)
                                           :text)
                             :warn_icon (. (vim.fn.sign_getdefined :DiagnosticSignWarn)
                                           :text)}
                    :update [:DiagnosticChanged :TabEnter]})

(local Git {1 Space
            2 {:hl {:bold true}
               :provider (fn [self] (.. " " self.status_dict.head))}
            3 Space
            4 {:condition (fn [self] self.has_changes) :provider "["}
            5 {:hl {:fg :green}
               :provider (fn [self] (local count (or self.status_dict.added 0))
                           (and (> count 0) (.. "+" count)))}
            6 {:hl {:fg :red}
               :provider (fn [self]
                           (local count (or self.status_dict.removed 0))
                           (and (> count 0) (.. "-" count)))}
            7 {:hl {:fg :orange}
               :provider (fn [self]
                           (local count (or self.status_dict.changed 0))
                           (and (> count 0) (.. "~" count)))}
            8 {:condition (fn [self] self.has_changes) :provider "]"}
            9 Space
            :condition conditions.is_git_repo
            :hl {:bg :magenta :fg :dark}
            :init (fn [self]
                    (set self.status_dict vim.b.gitsigns_status_dict)
                    (set self.has_changes
                         (or (or (not= self.status_dict.added 0)
                                 (not= self.status_dict.removed 0))
                             (not= self.status_dict.changed 0))))
            :on_click {:callback (fn [self minwid nclicks button]
                                   (vim.cmd :Neogit))
                       :name :heirline_git
                       :update false}})

(local Snippets {:condition (fn [] (vim.tbl_contains [:s :i] (vim.fn.mode)))
                 :hl {:bold true :fg :red}
                 :provider (fn []
                             (local forward
                                    (or (and (= ((. vim.fn
                                                    "UltiSnips#CanJumpForwards"))
                                                1)
                                             "")
                                        ""))
                             (local backward
                                    (or (and (= ((. vim.fn
                                                    "UltiSnips#CanJumpBackwards"))
                                                1)
                                             "")
                                        ""))
                             (.. backward forward))})

(local Work-dir
       {1 {:provider (fn [self]
                       (local trail
                              (or (and (= (self.cwd:sub (- 1)) "/") "") "/"))
                       (.. self.icon (self.cwd:gsub "~/.local/git" "") trail
                           " "))}
        :hl {:bold true :fg :dark}
        :on_click {:callback (fn []
                               ((. (require :ranger-nvim) :open) false))
                   :name :heirline_workdir}
        :provider (fn [self]
                    (set self.icon
                         (.. (or (and (= (vim.fn.haslocaldir 0) 1) :l) :g) " "
                             " "))
                    (local cwd (vim.fn.getcwd 0))
                    (set self.cwd (vim.fn.fnamemodify cwd ":~"))
                    (when (not (conditions.width_percent_below (length self.cwd)
                                                               0.27))
                      (set self.cwd (vim.fn.pathshorten self.cwd))))})

(local Help-filename
       {:condition (fn [] (= vim.bo.filetype :help))
        :hl {:fg :current_fg}
        :provider (fn [] (local filename (vim.api.nvim_buf_get_name 0))
                    (vim.fn.fnamemodify filename ":t"))})

(local Terminal-name
       [{:hl {:bold true :fg :blue}
         :provider (fn []
                     (local (tname _)
                            (: (vim.api.nvim_buf_get_name 0) :gsub ".*:" ""))
                     (.. " " tname))}
        {:provider " - "}
        {:provider (fn [] vim.b.term_title)}
        {:hl {:bold true :fg :blue}
         :provider (fn []
                     (local id (: (require :terminal) :current_term_index))
                     (.. " " (or id :Exited)))}])

(local Spell {:condition (fn [] vim.wo.spell)
              :hl {:bold true :fg :yellow}
              :provider "SPELL "})

(local Align {:provider "%="})

(local Default-statusline
       {1 Vi-mode
        2 Arrow-right-right
        3 Space
        4 Spell
        5 {1 {1 Arrow-right-right
              :hl (fn [self]
                    {:bg my.color.my.theme.bold-retro.primary :fg (vimode-color) :force true})}
           2 Space
           3 Work-dir
           4 Arrow-right-right
           :hl {:bg :magenta}}
        6 Space
        7 {1 Arrow-left-right 2 Git 3 Arrow-right-right :hl {:bg :magenta}}
        8 Space
        9 {1 {1 Arrow-left-left
              :hl (fn [self]
                    {:bg (vimode-color) :fg my.color.my.theme.bold-retro.attention :force true})
              :update :ModeChanged}
           2 Space
           3 Diagnostics
           4 Space
           5 {1 Arrow-right-right
              :hl (fn [self]
                    {:bg (vimode-color) :fg my.color.my.theme.bold-retro.attention :force true})
              :update :ModeChanged}
           :condition conditions.has_diagnostics
           :hl {:bg my.color.my.theme.bold-retro.attention :bold true}
           :update :ModeChanged}
        10 Align
        11 Arrow-left-left
        12 {1 Space 2 LSPActive 3 Space :hl {:bg :magenta :force true}}
        13 Arrow-right-left
        14 Space
        15 {1 Arrow-left-left
            2 Space
            3 File-type
            4 Space
            5 Arrow-right-left
            :hl {:bg :magenta}}
        16 Space
        17 {1 Arrow-left-left
            2 Space
            3 File-encoding
            4 File-last-modified
            5 Space
            6 Arrow-right-left
            :hl {:bg :magenta}}
        18 Space
        19 {1 Arrow-left-left 2 Space 3 Ruler :hl {:bg :magenta}}
        20 Scroll-bar
        :update [:VimEnter :ModeChanged]})

(local Inactive-statusline
       {1 {1 Work-dir :hl {:fg :gray :force true}}
        2 File-name-block
        3 {:provider "%<"}
        4 Align
        :condition (fn [] (not (conditions.is_active)))})

(local Special-statusline
       {1 {1 Vi-mode
           2 File-type}
        2 {:provider "%q"}
        3 Space
        4 Help-filename
        5 Align
        :condition (fn []
                     (conditions.buffer_matches {:buftype [:nofile
                                                           :prompt
                                                           :help
                                                           :quickfix]
                                                 :filetype [:^git.* :fugitive]}))})

(local Git-statusline
       {1 {1 Vi-mode
           2 File-type}
        2 Space
        3 {:provider (fn [] (vim.fn.FugitiveStatusline))}
        4 Space
        5 Align
        :condition (fn []
                     (conditions.buffer_matches {:filetype [:^git.* :fugitive]}))})

(local Terminal-statusline {1 {1 Vi-mode
                               2 Space
                               :condition conditions.is_active}
                            2 File-type
                            3 Space
                            4 Align
                            :condition (fn []
                                         (conditions.buffer_matches {:buftype [:terminal]}))
                            :hl {:bg :magenta}})

(local Status-lines {1 Git-statusline
                     2 Special-statusline
                     3 Terminal-statusline
                     4 Inactive-statusline
                     5 Default-statusline
                     :fallthrough true
                     :hl (fn []
                           (if (conditions.is_active) {:bg (vimode-color)}
                               {:bg my.color.my.theme.bold-retro.primary}))
                     :static {:mode_color (fn [self]
                                            (local mode
                                                   (or (and (conditions.is_active)
                                                            (vim.fn.mode))
                                                       :n))
                                            (local current-mode-color
                                                   (vimode-color))
                                            (vim.api.nvim_set_hl 0 :StatusLine
                                                                 {:bg current-mode-color})
                                            current-mode-color)}
                     :update [:DirChanged
                              :VimEnter
                              :ColorScheme
                              :ModeChanged
                              :WinNew]})

(local Close-button
       {1 {:provider " "}
        2 {:hl {:fg :gray}
           :on_click {:callback (fn [_ winid]
                                  (vim.api.nvim_win_close winid true))
                      :name (fn [self] (.. :heirline_close_button_ self.winnr))
                      :update true}
           :provider ""}
        :condition (fn [self] (not vim.bo.modified))
        :update [:WinNew :WinClosed :BufEnter]})

(local Tabline-bufnr
       {:hl :Comment :provider (fn [self] (.. (tostring self.bufnr) ". "))})

(local Tabline-file-name
       {:hl (fn [self]
              {:bold self.is_active
               :italic (or self.is_active self.is_visible)})
        :provider (fn [self]
                    (var filename self.filename)
                    (set filename
                         (or (and (= filename "") "[No Name]")
                             (vim.fn.fnamemodify filename ":t")))
                    (.. " " filename " "))})

(local Tabline-file-flags [{:condition (fn [self]
                                         (vim.api.nvim_buf_get_option self.bufnr
                                                                      :modified))
                            :hl {:fg my.color.my.theme.bold-retro.secondary}
                            :provider "[+]"}
                           {:condition (fn [self]
                                         (or (not (vim.api.nvim_buf_get_option self.bufnr
                                                                               :modifiable))
                                             (vim.api.nvim_buf_get_option self.bufnr
                                                                          :readonly)))
                            :hl {:bg my.color.my.black :fg my.color.my.theme.bold-retro.secondary}
                            :provider (fn [self]
                                        (if (= (vim.api.nvim_buf_get_option self.bufnr
                                                                            :buftype)
                                               :terminal)
                                            "  "
                                            ""))}])

(local Tabline-file-name-block
       {1 Tabline-bufnr
        2 {1 File-icon-bare
           :hl (fn [self]
                 (or (or (and self.is_active {:fg my.color.my.theme.bold-retro.primary})
                         (and self.is_visible {:fg my.color.my.dark}))
                     {:fg (my.color.util.darken my.color.my.light 50)}))}
        3 Tabline-file-name
        4 Tabline-file-flags
        :hl (fn [self]
              (if (or self.is_active self.is_visible) {:fg my.color.my.theme.bold-retro.secondary}
                  (not (vim.api.nvim_buf_is_loaded self.bufnr)) {:fg :gray}
                  {}))
        :init (fn [self]
                (set self.filename (vim.api.nvim_buf_get_name self.bufnr)))
        :on_click {:callback (fn [_ minwid _ button]
                               (if (= button :m)
                                   (vim.api.nvim_buf_delete minwid
                                                            {:force false})
                                   (vim.api.nvim_win_set_buf 0 minwid)))
                   :minwid (fn [self] self.bufnr)
                   :name :heirline_tabline_buffer_callback}})

(local Tabline-close-button
       {1 {:provider " "}
        2 {:hl {:fg :gray}
           :on_click {:callback (fn [_ minwid] (vim.cmd (.. "bp|bd " minwid)))
                      :minwid (fn [self] self.bufnr)
                      :name :heirline_tabline_close_buffer_callback}
           :provider ""}
        3 {:provider " "}
        :condition (fn [self]
                     (not (vim.api.nvim_buf_get_option self.bufnr :modified)))})

(local Tabline-picker
       {:condition (fn [self] self._show_picker)
        :hl {:bold true :fg :red}
        :init (fn [self]
                (var bufname (vim.api.nvim_buf_get_name self.bufnr))
                (set bufname (vim.fn.fnamemodify bufname ":t"))
                (var label (bufname:sub 1 1))
                (var i 2)
                (while (. self._picker_labels label)
                  (when (> i (length bufname)) (lua :break))
                  (set label (bufname:sub i i))
                  (set i (+ i 1)))
                (tset self._picker_labels label self.bufnr)
                (set self.label label))
        :provider (fn [self] (.. " " self.label))})

(local Tabline-buffer-block
       (utils.surround ["" ""]
                       (fn [self]
                         (if self.is_active
                             (vimode-color)
                             self.is_visible
                             (my.color.util.desaturate (vimode-color) 50)
                             ((. my.color.util
                                (.. (vim.opt.background:get) :en))
                              (vimode-color)
                              50)))
                       [Tabline-file-name-block
                        Tabline-picker
                        Tabline-close-button]))

(local Tabpage
       {:hl (fn [self]
              (if (not self.is_active)
                  :TabLine
                  {:bg (vimode-color) :force true}))
        :provider (fn [self] (.. "%" self.tabnr "T " self.tabnr " %T"))})

(local Tabpage-close {:condition (fn [self]
                                   (> (vim.tbl_count (vim.api.nvim_list_tabpages))
                                      1))
                      :hl :TabLine
                      :on_click {:callback (fn []
                                             (vim.api.nvim_win_close 0 true)
                                             (vim.cmd.redrawtabline))
                                 :name :heirline_tabline_close_tab_callback}
                      :provider "  "})

(local Tab-pages
       {1 {:provider "%="}
        2 (utils.make_tablist Tabpage)
        3 Tabpage-close
        :condition (fn []
                    (>= (length (vim.api.nvim_list_tabpages)) 2))})

(local Tab-line-offset
       {:condition (fn [self]
                     (local win (. (vim.api.nvim_tabpage_list_wins 0) 1))
                     (local bufnr (vim.api.nvim_win_get_buf win))
                     (set self.winid win)
                     (when (= (. vim.bo bufnr :filetype) :NvimTree)
                       (set self.title :NvimTree)
                       true))
        :hl (fn [self]
              (if (= (vim.api.nvim_get_current_win) self.winid) :TablineSel
                  :Tabline))
        :provider (fn [self]
                    (local title self.title)
                    (local width (vim.api.nvim_win_get_width self.winid))
                    (local pad (math.ceil (/ (- width (length title)) 2)))
                    (.. (string.rep " " pad) title (string.rep " " pad)))})

(local Buffer-line
       (utils.make_buflist Tabline-buffer-block
                           {:hl {:fg :gray} :provider "  "}
                           {:hl {:fg :gray} :provider "  "}
                           (fn [self]
                             (vim.tbl_filter (fn [bufnr]
                                               (and (not (not (: (vim.api.nvim_buf_get_name bufnr)
                                                                 :find
                                                                 (vim.fn.getcwd)
                                                                 0 true)))
                                                    (not (conditions.buffer_matches {:buftype [:.*git.*
                                                                                               :terminal
                                                                                               :nofile
                                                                                               :prompt
                                                                                               :help
                                                                                               :quickfix]
                                                                                     :filetype [:wilder
                                                                                                :packer
                                                                                                :neo-tree
                                                                                                :which-key
                                                                                                :Diffview.*
                                                                                                :NeogitStatus
                                                                                                :.*git.*
                                                                                                :^git.*
                                                                                                :fugitive]}
                                                                                    bufnr))
                                                    (vim.api.nvim_buf_is_loaded bufnr)))
                                             (vim.api.nvim_list_bufs)))))

(local Tab-line {1 Tab-line-offset
                 2 Buffer-line
                 3 Tab-pages
                 :hl {:bg my.color.my.theme.bold-retro.primary}
                 :init (fn [self] (set self.bufferline Buffer-line))
                 :update [:DirChanged
                          :BufLeave
                          :BufEnter
                          :BufWinEnter
                          :ModeChanged
                          :BufModifiedSet
                          :TabEnter
                          :OptionSet
                          :WinNew]})

(local Win-bar {1 {1 Space
                   2 File-name-block
                   3 Space
                   4 {:hl {:bold true :fg my.color.my.theme.bold-retro.normal} :provider ""}
                   :hl (fn [] {:bg my.color.my.theme.bold-retro.primary :fg my.color.my.dark})}
                2 {5 Space
                   6 {1 Navic
                      :condition (fn []
                                    (when ((. (require :nvim-navic) :is_available) (vim.api.nvim_get_current_buf))
                                      (local data
                                        ((. (require :nvim-navic) :get_data)))
                                      (var data-len 0)
                                      (each [_ _ (pairs (or data {}))]
                                        (set data-len (+ data-len 1)))
                                      (let [___antifnl_rtn_1___ (> data-len 0)]
                                        (lua "return ___antifnl_rtn_1___")))
                                    false)
                      :hl (fn [] {:bg my.color.my.theme.bold-retro.primary :fg my.color.my.dark})}
                   7 {1 Dropbar
                      :condition (fn []
                                    (when ((. (require :nvim-navic) :is_available) (vim.api.nvim_get_current_buf))
                                      (local data
                                        ((. (require :nvim-navic) :get_data)))
                                      (each [_ _ (pairs (or data {}))]
                                        (lua "return false")))
                                    true)
                      :hl (fn [] {:bg my.color.my.theme.bold-retro.primary :fg my.color.my.dark})}}
                3 {:hl (fn [self]
                         {:bg (vimode-color)
                          :fg my.color.my.theme.bold-retro.primary
                          :force true})
                   :provider ""}
                4 Align
                5 {1 {:provider (fn [self] "")
                      :hl (fn [self]
                            {:bg (vimode-color)
                             :fg my.color.my.theme.bold-retro.secondary
                             :force true})}
                   2 {1 Buffer-local-diagnostics
                      2 Space
                      :hl {:fg my.color.my.theme.bold-retro.primary :bg my.color.my.theme.bold-retro.secondary :force true}}
                   3 {:hl (fn [self]
                            {:bg (vimode-color)
                             :fg my.color.my.theme.bold-retro.secondary
                             :force true})
                      :provider (fn [self] "")}
                   :condition conditions.has_diagnostics
                   :hl (fn [self]
                         (when (not (conditions.is_active))
                           (let [___antifnl_rtn_1___ {:bg my.color.my.theme.bold-retro.attention
                                                      :fg my.color.my.light
                                                      :force true}]
                             (lua "return ___antifnl_rtn_1___")))
                         {:bg my.color.my.theme.bold-retro.secondary :fg my.color.my.theme.bold-retro.primary :bold true})
                   :update [:CursorMoved :ModeChanged :BufEnter :BufWinEnter]}
                6 Space
                7 {:hl {:bg :vimode :fg my.color.my.theme.bold-retro.primary :force true}
                   :provider ""
                   :update [:ModeChanged]}
                8 {:hl {:bg my.color.my.theme.bold-retro.primary :fg my.color.my.dark :force true}
                   :provider (fn [self] (.. " #" self.winnr))}
                :hl {:bg :vimode :fg my.color.my.theme.bold-retro.primary}
                :update [:CursorMoved :ModeChanged]})

(local Win-bars {1 {:condition (fn []
                                 (or (not (conditions.buffer_matches {:filetype [:fennel
                                                                                 :dart
                                                                                 :lua
                                                                                 :clojure
                                                                                 :clojurescript
                                                                                 :clj
                                                                                 :cljs
                                                                                 :ts
                                                                                 :tsx
                                                                                 :typescript
                                                                                 :typescriptreact
                                                                                 :js
                                                                                 :jsx
                                                                                 :javascript
                                                                                 :javascriptreact
                                                                                 :html
                                                                                 :css
                                                                                 :json
                                                                                 :md
                                                                                 :sass
                                                                                 :less
                                                                                 :yml
                                                                                 :yaml]}))
                                     (conditions.buffer_matches {:buftype [:.*git.*
                                                                           :terminal
                                                                           :nofile
                                                                           :prompt
                                                                           :help
                                                                           :quickfix]
                                                                 :filetype [:wilder
                                                                            :packer
                                                                            :neo-tree
                                                                            :which-key
                                                                            :Diffview.*
                                                                            :NeogitStatus
                                                                            :.*git.*
                                                                            :^git.*
                                                                            :fugitive]})))
                    :init (fn [])}
                 2 Win-bar
                 :fallthrough false
                 :update [:ModeChanged
                          :VimEnter
                          :ColorScheme
                          :WinNew
                          :OptionSet]})

(local M {})

(fn M.update []
  (: (. (require :heirline) :statusline) :broadcast
     (fn [self] (set self._win_stl nil)))
  ((. (require :heirline.utils) :on_colorscheme) (setup-colors))
  (vim.api.nvim_set_hl 0 :StatusLine
                       {:bg (. my.color.my.vimode (or (vim.fn.mode) :n))})
  (vim.api.nvim_set_hl 0 :ScrollbarHandle
                       {:bg (. my.color.my.vimode (or (vim.fn.mode) :n))}))

(fn M.aucmds []
  (vim.api.nvim_create_augroup :Heirline {:clear true})
  (vim.api.nvim_create_autocmd :User
                               {:callback (fn [args]
                                            (local buf args.buf)
                                            (local buftype
                                                   (vim.tbl_contains [:terminal
                                                                      :prompt
                                                                      :nofile
                                                                      :help
                                                                      :quickfix]
                                                                     (. vim.bo
                                                                        buf
                                                                        :buftype)))
                                            (local filetype
                                                   (vim.tbl_contains [:wilder
                                                                      :packer
                                                                      :which-key
                                                                      :Diffview.*
                                                                      :NeogitStatus
                                                                      :gitcommit
                                                                      :fugitive]
                                                                     (. vim.bo
                                                                        buf
                                                                        :filetype)))
                                            (when (or buftype filetype)
                                              (set vim.opt_local.winbar nil)))
                                :group :Heirline
                                :pattern :HeirlineInitWinbar})
  (vim.api.nvim_create_autocmd :ModeChanged
                               {:callback M.update
                                :group :Heirline
                                :pattern "*"}))

(fn M.load_colors []
  ((. (require :heirline) :load_colors) (setup-colors)))

(fn M.setup [my-aucmds]
  ((. (require :heirline) :load_colors) (setup-colors))
  ; (vim.api.nvim_set_hl 0 :TabLine {:bg my.color.my.theme.bold-retro.primary})
  ; (vim.api.nvim_set_hl 0 :TabLineSel {:bg (. my.color.my.vimode (vim.fn.mode))})
  ; (vim.api.nvim_set_hl 0 :TabLineFill {:bg my.color.my.theme.bold-retro.primary})
  (vim.api.nvim_set_hl 0 :StatusLine {:bg (vimode-color)})
  (vim.api.nvim_set_hl 0 :WinBar {:bg (vimode-color)})
  ((. (require :heirline) :setup) {:statusline Status-lines :winbar Win-bars}) ; :tabline Tab-line})
  (when (= my-aucmds true)
    (vim.cmd "au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif")
    (M.aucmds)))

(set M.StatusLines Status-lines)
; (set M.TabLines Tab-line)
(set M.WinBars Win-bars)

M

