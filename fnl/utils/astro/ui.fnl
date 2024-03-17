; ### AstroNvim UI Options
;
; Utility functions for easy UI toggles.
;
; This module can be loaded with `local ui = require("utils.astro.ui")`
;
; @module utils.astro.ui
; @see utils.astro
; @copyright 2022
; @license GNU General Public License v3.0

(local M {})
(fn bool2str [bool] (or (and bool :on) :off))
(fn ui-notify [silent ...]
  (and (not silent) ((. (require :utils.astro) :notify) ...)))
(fn M.toggle_ui_notifications [silent]
  (set vim.g.ui_notifications_enabled (not vim.g.ui_notifications_enabled))
  (ui-notify silent
             (string.format "Notifications %s"
                            (bool2str vim.g.ui_notifications_enabled))))
(fn M.toggle_autopairs [silent]
  (let [(ok autopairs) (pcall require :nvim-autopairs)]
    (if ok
        (do
          (if autopairs.state.disabled (autopairs.enable) (autopairs.disable))
          (set vim.g.autopairs_enabled autopairs.state.disabled)
          (ui-notify silent
                     (string.format "autopairs %s"
                                    (bool2str (not autopairs.state.disabled)))))
        (ui-notify silent "autopairs not available"))))
(fn M.toggle_diagnostics [silent]
  (set vim.g.diagnostics_mode (% (- vim.g.diagnostics_mode 1) 4))
  (vim.diagnostic.config (. (. (require :utils.astro.lsp) :diagnostics)
                            vim.g.diagnostics_mode))
  (if (= vim.g.diagnostics_mode 0) (ui-notify silent "diagnostics off")
      (= vim.g.diagnostics_mode 1) (ui-notify silent "only status diagnostics")
      (= vim.g.diagnostics_mode 2) (ui-notify silent "virtual text off")
      (ui-notify silent "all diagnostics on")))
(fn M.toggle_background [silent]
  (set vim.go.background (or (and (= vim.go.background :light) :dark) :light))
  (ui-notify silent (string.format "background=%s" vim.go.background)))
(fn M.toggle_cmp [silent]
  (set vim.g.cmp_enabled (not vim.g.cmp_enabled))
  (local (ok _) (pcall require :cmp))
  (ui-notify silent (or (and ok
                             (string.format "completion %s"
                                            (bool2str vim.g.cmp_enabled)))
                        "completion not available")))
(fn M.toggle_autoformat [silent]
  (set vim.g.autoformat_enabled (not vim.g.autoformat_enabled))
  (ui-notify silent
             (string.format "Global autoformatting %s"
                            (bool2str vim.g.autoformat_enabled))))
(fn M.toggle_buffer_autoformat [bufnr silent]
  (set-forcibly! bufnr (or bufnr 0))
  (var old-val (. (. vim.b bufnr) :autoformat_enabled))
  (when (= old-val nil) (set old-val vim.g.autoformat_enabled))
  (tset (. vim.b bufnr) :autoformat_enabled (not old-val))
  (ui-notify silent
             (string.format "Buffer autoformatting %s"
                            (bool2str (. (. vim.b bufnr) :autoformat_enabled)))))
(fn M.toggle_buffer_semantic_tokens [bufnr silent]
  (set-forcibly! bufnr (or bufnr 0))
  (tset (. vim.b bufnr) :semantic_tokens_enabled
        (not (. (. vim.b bufnr) :semantic_tokens_enabled)))
  (var toggled false)
  (each [_ client (ipairs (vim.lsp.get_active_clients {: bufnr}))]
    (when client.server_capabilities.semanticTokensProvider
      ((. vim.lsp.semantic_tokens (or (and (. (. vim.b bufnr)
                                              :semantic_tokens_enabled)
                                           :start)
                                      :stop)) bufnr
                                                                                                                                                                                                                                       client.id)
      (set toggled true)))
  (ui-notify (or (not toggled) silent)
             (string.format "Buffer lsp semantic highlighting %s"
                            (bool2str (. (. vim.b bufnr)
                                         :semantic_tokens_enabled)))))
(fn M.toggle_buffer_inlay_hints [bufnr silent]
  (set-forcibly! bufnr (or bufnr 0))
  (tset (. vim.b bufnr) :inlay_hints_enabled
        (not (. (. vim.b bufnr) :inlay_hints_enabled)))
  (when vim.lsp.inlay_hint
    (vim.lsp.inlay_hint.enable bufnr (. (. vim.b bufnr) :inlay_hints_enabled))
    (ui-notify silent
               (string.format "Inlay hints %s"
                              (bool2str (. (. vim.b bufnr) :inlay_hints_enabled))))))
(fn M.toggle_codelens [silent]
  (set vim.g.codelens_enabled (not vim.g.codelens_enabled))
  (when (not vim.g.codelens_enabled) (vim.lsp.codelens.clear))
  (ui-notify silent
             (string.format "CodeLens %s" (bool2str vim.g.codelens_enabled))))
(fn M.toggle_tabline [silent]
  (set vim.opt.showtabline (or (and (= (vim.opt.showtabline:get) 0) 2) 0))
  (ui-notify silent
             (string.format "tabline %s"
                            (bool2str (= (vim.opt.showtabline:get) 2)))))
(fn M.toggle_conceal [silent]
  (set vim.opt.conceallevel (or (and (= (vim.opt.conceallevel:get) 0) 2) 0))
  (ui-notify silent
             (string.format "conceal %s"
                            (bool2str (= (vim.opt.conceallevel:get) 2)))))
(fn M.toggle_statusline [silent]
  (let [laststatus (vim.opt.laststatus:get)]
    (var status nil)
    (if (= laststatus 0) (do
                           (set vim.opt.laststatus 2)
                           (set status :local))
        (= laststatus 2) (do
                          (set vim.opt.laststatus 3)
                          (set status :global))
        (= laststatus 3) (do
                          (set vim.opt.laststatus 0)
                          (set status :off)))
    (ui-notify silent (string.format "statusline %s" status))))
(fn M.toggle_signcolumn [silent]
  (if (= vim.wo.signcolumn :no) (set vim.wo.signcolumn :yes)
      (= vim.wo.signcolumn :yes) (set vim.wo.signcolumn :auto)
      (set vim.wo.signcolumn :no))
  (ui-notify silent (string.format "signcolumn=%s" vim.wo.signcolumn)))
(fn M.set_indent [silent]
  (let [(input-avail input) (pcall vim.fn.input
                                   "Set indent value (>0 expandtab, <=0 noexpandtab): ")]
    (when input-avail
      (var indent (tonumber input))
      (when (or (not indent) (= indent 0)) (lua "return "))
      (set vim.bo.expandtab (> indent 0))
      (set indent (math.abs indent))
      (set vim.bo.tabstop indent)
      (set vim.bo.softtabstop indent)
      (set vim.bo.shiftwidth indent)
      (ui-notify silent
                 (string.format "indent=%d %s" indent
                                (or (and vim.bo.expandtab :expandtab)
                                    :noexpandtab))))))
(fn M.change_number [silent]
  (let [number vim.wo.number
        relativenumber vim.wo.relativenumber]
    (if (and (not number) (not relativenumber)) (set vim.wo.number true)
        (and number (not relativenumber)) (set vim.wo.relativenumber true)
        (and number relativenumber) (set vim.wo.number false)
        (set vim.wo.relativenumber false))
    (ui-notify silent
               (string.format "number %s, relativenumber %s"
                              (bool2str vim.wo.number)
                              (bool2str vim.wo.relativenumber)))))
(fn M.toggle_spell [silent]
  (set vim.wo.spell (not vim.wo.spell))
  (ui-notify silent (string.format "spell %s" (bool2str vim.wo.spell))))
(fn M.toggle_paste [silent]
  (set vim.opt.paste (not (vim.opt.paste:get)))
  (ui-notify silent (string.format "paste %s" (bool2str (vim.opt.paste:get)))))
(fn M.toggle_wrap [silent]
  (set vim.wo.wrap (not vim.wo.wrap))
  (ui-notify silent (string.format "wrap %s" (bool2str vim.wo.wrap))))
(fn M.toggle_buffer_syntax [bufnr silent]
  (set-forcibly! bufnr (or (and (and bufnr (not= bufnr 0)) bufnr)
                           (vim.api.nvim_win_get_buf 0)))
  (local (ts-avail parsers) (pcall require :nvim-treesitter.parsers))
  (if (= (. (. vim.bo bufnr) :syntax) :off)
      (do
        (when (and ts-avail (parsers.has_parser)) (vim.treesitter.start bufnr))
        (tset (. vim.bo bufnr) :syntax :on)
        (when (not (. (. vim.b bufnr) :semantic_tokens_enabled))
          (M.toggle_buffer_semantic_tokens bufnr true)))
      (do
        (when (and ts-avail (parsers.has_parser)) (vim.treesitter.stop bufnr))
        (tset (. vim.bo bufnr) :syntax :off)
        (when (. (. vim.b bufnr) :semantic_tokens_enabled)
          (M.toggle_buffer_semantic_tokens bufnr true))))
  (ui-notify silent (string.format "syntax %s" (. (. vim.bo bufnr) :syntax))))
(set M.toggle_syntax M.toggle_buffer_syntax)
(fn M.toggle_url_match [silent]
  (set vim.g.highlighturl_enabled (not vim.g.highlighturl_enabled))
  ((. (require :utils.astro) :set_url_match))
  (ui-notify silent
             (string.format "URL highlighting %s"
                            (bool2str vim.g.highlighturl_enabled))))
(var last-active-foldcolumn nil)
(fn M.toggle_foldcolumn [silent]
  (let [curr-foldcolumn vim.wo.foldcolumn]
    (when (not= curr-foldcolumn :0)
      (set last-active-foldcolumn curr-foldcolumn))
    (set vim.wo.foldcolumn (or (and (= curr-foldcolumn :0)
                                    (or last-active-foldcolumn :1))
                               :0))
    (ui-notify silent (string.format "foldcolumn=%s" vim.wo.foldcolumn))))
M
