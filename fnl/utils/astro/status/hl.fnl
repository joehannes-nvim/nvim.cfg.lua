; ### AstroNvim Status Highlighting
;
; Statusline related highlighting utilities
;
; This module can be loaded with `local hl = require "astronvim.utils.status.hl"`
;
; @module astronvim.utils.status.hl
; @copyright 2023
; @license GNU General Public License v3.0

(local M {})
(local env (require :utils.astro.status.env))
(fn M.lualine_mode [mode fallback]
  (when (not vim.g.colors_name) (lua "return fallback"))
  (local (lualine-avail lualine)
         (pcall require (.. :lualine.themes. vim.g.colors_name)))
  (local lualine-opts (and lualine-avail (. lualine mode)))
  (or (and (and lualine-opts (= (type lualine-opts.a) :table))
           lualine-opts.a.bg) fallback))
(fn M.mode [] {:bg (M.mode_bg)})
(fn M.mode_bg []
  (. (. env.modes (vim.fn.mode)) 2))
(fn M.filetype_color [self]
  (let [(devicons-avail devicons) (pcall require :nvim-web-devicons)]
    (when (not devicons-avail)
      (let [___antifnl_rtn_1___ {}] (lua "return ___antifnl_rtn_1___")))
    (local (_ color)
           (devicons.get_icon_color (vim.fn.fnamemodify (vim.api.nvim_buf_get_name (or (and self
                                                                                            self.bufnr)
                                                                                       0))
                                                        ":t")
                                    nil {:default true}))
    {:fg color}))
(fn M.get_attributes [name include-bg]
  (let [hl (or (. env.attributes name) {})]
    (set hl.fg (.. name :_fg))
    (when include-bg (set hl.bg (.. name :_bg)))
    hl))
(fn M.file_icon [name]
  (let [hl-enabled (. env.icon_highlights.file_icon name)]
    (fn [self]
      (when (or (= hl-enabled true)
                (and (= (type hl-enabled) :function) (hl-enabled self)))
        (M.filetype_color self)))))
M
