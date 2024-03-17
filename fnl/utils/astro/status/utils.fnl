; ### AstroNvim Status Utilities
;
; Statusline related uitility functions
;
; This module can be loaded with `local status_utils = require "astronvim.utils.status.utils"`
;
; @module astronvim.utils.status.utils
; @copyright 2023
; @license GNU General Public License v3.0

(local M {})
(local env (require :utils.astro.status.env))
(local utils (require :utils.astro))
(local extend-tbl utils.extend_tbl)
(local get-icon utils.get_icon)
(fn M.build_provider [opts provider _]
  (or (and opts {:condition opts.condition
                 :hl opts.hl
                 :on_click opts.on_click
                 : opts
                 : provider
                 :update opts.update}) false))
(fn M.setup_providers [opts providers setup]
  (set-forcibly! setup (or setup M.build_provider))
  (each [i provider (ipairs providers)]
    (tset opts i (setup (. opts provider) provider i)))
  opts)
(fn M.width [is-winbar]
  (or (and (and (= vim.o.laststatus 3) (not is-winbar)) vim.o.columns)
      (vim.api.nvim_win_get_width 0)))
(fn M.pad_string [str padding]
  (set-forcibly! padding (or padding {}))
  (or (and (and str (not= str ""))
           (.. (string.rep " " (or padding.left 0)) str
               (string.rep " " (or padding.right 0)))) ""))
(fn escape [str] (str:gsub "%%" "%%%%"))
(fn M.stylize [str opts]
  (set-forcibly! opts (extend-tbl {:escape true
                                   :icon {:kind :NONE
                                          :padding {:left 0 :right 0}}
                                   :padding {:left 0 :right 0}
                                   :separator {:left "" :right ""}
                                   :show_empty false}
                                  opts))
  (local icon (M.pad_string (get-icon opts.icon.kind) opts.icon.padding))
  (or (and (and str (or (not= str "") opts.show_empty))
           (.. opts.separator.left
               (M.pad_string (.. icon (or (and opts.escape (escape str)) str))
                             opts.padding) opts.separator.right)) ""))
(fn M.surround [separator color component condition]
  (fn surround-color [self]
    (let [colors (or (and (= (type color) :function) (color self)) color)]
      (or (and (= (type colors) :string) {:main colors}) colors)))

  (set-forcibly! separator (or (and (= (type separator) :string)
                                    (. env.separators separator))
                               separator))
  (local surrounded {: condition})
  (when (not= (. separator 1) "")
    (table.insert surrounded
                  {:hl (fn [self] (local s-color (surround-color self))
                         (when s-color {:bg s-color.left :fg s-color.main}))
                   :provider (. separator 1)}))
  (table.insert surrounded
                {1 (extend-tbl component {})
                 :hl (fn [self] (local s-color (surround-color self))
                       (when s-color {:bg s-color.main}))})
  (when (not= (. separator 2) "")
    (table.insert surrounded
                  {:hl (fn [self] (local s-color (surround-color self))
                         (when s-color {:bg s-color.right :fg s-color.main}))
                   :provider (. separator 2)}))
  surrounded)
(fn M.encode_pos [line col winnr]
  (bit.bor (bit.lshift line 16) (bit.lshift col 6) winnr))
(fn M.decode_pos [c]
  (values (bit.rshift c 16) (bit.band (bit.rshift c 6) 1023) (bit.band c 63)))
(fn M.null_ls_providers [filetype]
  (let [registered {}
        (sources-avail sources) (pcall require :null-ls.sources)]
    (when sources-avail
      (each [_ source (ipairs (sources.get_available filetype))]
        (each [method (pairs source.methods)]
          (tset registered method (or (. registered method) {}))
          (table.insert (. registered method) source.name))))
    registered))
(fn M.null_ls_sources [filetype method]
  (let [(methods-avail methods) (pcall require :null-ls.methods)]
    (or (and methods-avail
             (. (M.null_ls_providers filetype) (. methods.internal method)))
        {})))
(fn M.statuscolumn_clickargs [self minwid clicks button mods]
  (let [args {: button : clicks : minwid : mods :mousepos (vim.fn.getmousepos)}]
    (when (not self.signs) (set self.signs {}))
    (set args.char
         (vim.fn.screenstring args.mousepos.screenrow args.mousepos.screencol))
    (when (= args.char " ")
      (set args.char
           (vim.fn.screenstring args.mousepos.screenrow
                                (- args.mousepos.screencol 1))))
    (set args.sign (. self.signs args.char))
    (when (not args.sign)
      (each [_ sign-def (ipairs (vim.fn.sign_getdefined))]
        (when sign-def.text
          (tset self.signs (sign-def.text:gsub "%s" "") sign-def)))
      (set args.sign (. self.signs args.char)))
    (vim.api.nvim_set_current_win args.mousepos.winid)
    (vim.api.nvim_win_set_cursor 0 [args.mousepos.line 0])
    args))
M
