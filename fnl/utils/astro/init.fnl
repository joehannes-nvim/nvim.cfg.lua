; Reuse Astronvim
; ### AstroNvim Utilities
;
; @module astronvim.utils
; @copyright 2022
; @license GNU General Public License v3.0

(local M {})

(fn M.extend_tbl [default opts]
  (set-forcibly! opts (or opts {}))
  (or (and default (vim.tbl_deep_extend :force default opts)) opts))
(fn M.reload [quiet]
  (let [was-modifiable (vim.opt.modifiable:get)]
    (when (not was-modifiable) (set vim.opt.modifiable true))
    (local core-modules [:_G.my.bootstrap
                         :_G.my.options
                         :_G.my.mappings])
    (local modules
           (vim.tbl_filter (fn [module] (module:find "^user%."))
                           (vim.tbl_keys package.loaded)))
    (vim.tbl_map (. (require :plenary.reload) :reload_module)
                 (vim.list_extend modules core-modules))
    (var success true)
    (each [_ module (ipairs core-modules)]
      (local (status-ok fault) (pcall require module))
      (when (not status-ok)
        (vim.api.nvim_err_writeln (.. "Failed to load " module "\n\n" fault))
        (set success false)))
    (when (not was-modifiable) (set vim.opt.modifiable false))
    (when (not quiet)
      (if success (M.notify "AstroNvim successfully reloaded"
                            vim.log.levels.INFO)
          (M.notify "Error reloading AstroNvim..." vim.log.levels.ERROR)))
    (vim.cmd.doautocmd :ColorScheme)
    success))
(fn M.list_insert_unique [lst vals]
  (when (not lst) (set-forcibly! lst {}))
  (assert (vim.tbl_islist lst) "Provided table is not a list like table")
  (when (not (vim.tbl_islist vals)) (set-forcibly! vals [vals]))
  (local added {})
  (vim.tbl_map (fn [v] (tset added v true)) lst)
  (each [_ val (ipairs vals)]
    (when (not (. added val)) (table.insert lst val) (tset added val true)))
  lst)
(fn M.conditional_func [func condition ...]
  (when (and condition (= (type func) :function))
    (func ...)))
(fn M.get_icon [kind padding no-fallback]
  (when (and (not vim.g.icons_enabled) no-fallback) (lua "return \"\""))
  (local icon-pack (or (and vim.g.icons_enabled :icons) :text_icons))
  (when (not (. M icon-pack))
    (set M.icons
         (_G.my.user_opts :icons (require :_G.my.icons.nerd_font)))
    (set M.text_icons
         (_G.my.user_opts :text_icons (require :_G.my.icons.text))))
  (local icon (and (. M icon-pack) (. (. M icon-pack) kind)))
  (or (and icon (.. icon (string.rep " " (or padding 0)))) ""))
(fn M.get_spinner [kind ...]
  (let [spinner {}]
    (while true
      (local icon (M.get_icon (: "%s%d" :format kind (+ (length spinner) 1))
                              ...))
      (when (not= icon "") (table.insert spinner icon))
      (when (or (not icon) (= icon "")) (lua :break)))
    (when (> (length spinner) 0) spinner)))
(fn M.get_hlgroup [name fallback]
  (when (= (vim.fn.hlexists name) 1)
    (var hl nil)
    (if vim.api.nvim_get_hl
        (do
          (set hl (vim.api.nvim_get_hl 0 {:link false : name}))
          (when (not hl.fg) (set hl.fg :NONE))
          (when (not hl.bg) (set hl.bg :NONE)))
        (do
          (set hl (vim.api.nvim_get_hl_by_name name vim.o.termguicolors))
          (when (not hl.foreground) (set hl.foreground :NONE))
          (when (not hl.background) (set hl.background :NONE))
          (set (hl.fg hl.bg) (values hl.foreground hl.background))
          (set (hl.ctermfg hl.ctermbg) (values hl.fg hl.bg))
          (set hl.sp hl.special)))
    (lua "return hl"))
  (or fallback {}))
(fn M.notify [msg type opts]
  (vim.schedule (fn []
                  (vim.notify msg type (M.extend_tbl {:title :AstroNvim} opts)))))
(fn M.event [event delay]
  (fn emit-event []
    (vim.api.nvim_exec_autocmds :User
                                {:modeline false :pattern (.. :Astro event)}))

  (if (= delay false) (emit-event) (vim.schedule emit-event)))
(fn M.system_open [path]
  (when vim.ui.open
    (let [___antifnl_rtns_1___ [(vim.ui.open path)]]
      (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
  (var cmd nil)
  (if (and (= (vim.fn.has :win32) 1) (= (vim.fn.executable :explorer) 1))
      (set cmd [:cmd.exe :/K :explorer])
      (and (= (vim.fn.has :unix) 1) (= (vim.fn.executable :xdg-open) 1))
      (set cmd [:xdg-open])
      (and (or (= (vim.fn.has :mac) 1) (= (vim.fn.has :unix) 1))
           (= (vim.fn.executable :open) 1)) (set cmd [:open]))
  (when (not cmd)
    (M.notify "Available system opening tool not found!" vim.log.levels.ERROR))
  (vim.fn.jobstart (vim.fn.extend cmd [(or path (vim.fn.expand :<cfile>))])
                   {:detach true}))
(fn M.toggle_term_cmd [opts]
  (let [terms _G.my.user_terminals]
    (when (= (type opts) :string) (set-forcibly! opts {:cmd opts :hidden true}))
    (local num (or (and (> vim.v.count 0) vim.v.count) 1))
    (when (not (. terms opts.cmd)) (tset terms opts.cmd {}))
    (when (not (. (. terms opts.cmd) num))
      (when (not opts.count)
        (set opts.count (+ (* (vim.tbl_count terms) 100) num)))
      (when (not opts.on_exit)
        (set opts.on_exit (fn [] (tset (. terms opts.cmd) num nil))))
      (tset (. terms opts.cmd) num
            (: (. (require :toggleterm.terminal) :Terminal) :new opts)))
    (: (. (. terms opts.cmd) num) :toggle)))
(fn M.alpha_button [sc txt]
  (let [sc- (: (sc:gsub "%s" "") :gsub :LDR :<Leader>)]
    (when vim.g.mapleader
      (set-forcibly! sc (sc:gsub :LDR
                                 (or (and (= vim.g.mapleader " ") :SPC)
                                     vim.g.mapleader))))
    {:on_press (fn []
                 (local key
                        (vim.api.nvim_replace_termcodes sc- true false true))
                 (vim.api.nvim_feedkeys key :normal false))
     :opts {:align_shortcut :right
            :cursor (- 2)
            :hl :DashboardCenter
            :hl_shortcut :DashboardShortcut
            :position :center
            :shortcut sc
            :text txt
            :width 36}
     :type :button
     :val txt}))
(fn M.is_available [plugin]
  (let [(lazy-config-avail lazy-config) (pcall require :lazy.core.config)]
    (and lazy-config-avail (not= (. lazy-config.spec.plugins plugin) nil))))
(fn M.plugin_opts [plugin]
  (let [(lazy-config-avail lazy-config) (pcall require :lazy.core.config)
        (lazy-plugin-avail lazy-plugin) (pcall require :lazy.core.plugin)]
    (var opts {})
    (when (and lazy-config-avail lazy-plugin-avail)
      (local spec (. lazy-config.spec.plugins plugin))
      (when spec (set opts (lazy-plugin.values spec :opts))))
    opts))
(fn M.load_plugin_with_func [plugin module func-names]
  (when (= (type func-names) :string) (set-forcibly! func-names [func-names]))
  (each [_ func (ipairs func-names)]
    (local old-func (. module func))
    (tset module func (fn [...]
                        (tset module func old-func)
                        ((. (require :lazy) :load) {:plugins [plugin]})
                        ((. module func) ...)))))
(fn M.which_key_register []
  (when M.which_key_queue
    (local (wk-avail wk) (pcall require :which-key))
    (when wk-avail
      (each [mode registration (pairs M.which_key_queue)]
        (wk.register registration {: mode}))
      (set M.which_key_queue nil))))
(fn M.empty_map_table []
  (let [maps {}]
    (each [_ mode (ipairs ["" :n :v :x :s :o "!" :i :l :c :t])]
      (tset maps mode {}))
    (when (= (vim.fn.has :nvim-0.10.0) 1)
      (each [_ abbr-mode (ipairs [:ia :ca :!a])]
        (tset maps abbr-mode {})))
    maps))
(fn M.set_mappings [map-table base]
  (set-forcibly! base (or base {}))
  (each [mode maps (pairs map-table)]
    (each [keymap options (pairs maps)]
      (when options
        (var cmd options)
        (var keymap-opts base)
        (when (= (type options) :table) (set cmd (. options 1))
          (set keymap-opts (vim.tbl_deep_extend :force keymap-opts options))
          (tset keymap-opts 1 nil))
        (if (or (not cmd) keymap-opts.name)
            (do
              (when (not keymap-opts.name)
                (set keymap-opts.name keymap-opts.desc))
              (when (not M.which_key_queue) (set M.which_key_queue {}))
              (when (not (. M.which_key_queue mode))
                (tset M.which_key_queue mode {}))
              (tset (. M.which_key_queue mode) keymap keymap-opts))
            (vim.keymap.set mode keymap cmd keymap-opts)))))
  (when (. package.loaded :which-key) (M.which_key_register)))
(set M.url_matcher
     "\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+")
(fn M.delete_url_match []
  (each [_ ___match___ (ipairs (vim.fn.getmatches))]
    (when (= ___match___.group :HighlightURL)
      (vim.fn.matchdelete ___match___.id))))
(fn M.set_url_match [] (M.delete_url_match)
  (when vim.g.highlighturl_enabled
    (vim.fn.matchadd :HighlightURL M.url_matcher 15)))
(fn M.cmd [cmd show-error]
  (when (= (type cmd) :string) (set-forcibly! cmd [cmd]))
  (when (= (vim.fn.has :win32) 1)
    (set-forcibly! cmd (vim.list_extend [:cmd.exe :/C] cmd)))
  (local result (vim.fn.system cmd))
  (local success (= (vim.api.nvim_get_vvar :shell_error) 0))
  (when (and (not success) (or (= show-error nil) show-error))
    (vim.api.nvim_err_writeln (: "Error running command %s\nError message:\n%s"
                                 :format (table.concat cmd " ") result)))
  (or (and success (result:gsub "[\027\155][][()#;?%d]*[A-PRZcf-ntqry=><~]" ""))
      nil))

M
