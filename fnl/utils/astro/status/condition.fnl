; ### AstroNvim Status Conditions
;
; Statusline related condition functions to use with Heirline
;
; This module can be loaded with `local condition = require "astronvim.utils.status.condition"`
;
; @module astronvim.utils.status.condition
; @copyright 2023
; @license GNU General Public License v3.0

(local M {})
(local env (require :utils.astro.status.env))
(fn M.is_active []
  (= (vim.api.nvim_get_current_win) (tonumber vim.g.actual_curwin)))
(fn M.buffer_matches [patterns bufnr]
  (each [kind pattern-list (pairs patterns)]
    (when ((. env.buf_matchers kind) pattern-list bufnr) (lua "return true")))
  false)
(fn M.is_macro_recording [] (not= (vim.fn.reg_recording) ""))
(fn M.is_hlsearch [] (not= vim.v.hlsearch 0))
(fn M.is_statusline_showcmd []
  (and (= (vim.fn.has :nvim-0.9) 1) (= (vim.opt.showcmdloc:get) :statusline)))
(fn M.is_git_repo [bufnr]
  (when (= (type bufnr) :table) (set-forcibly! bufnr bufnr.bufnr))
  (or (. (. vim.b (or bufnr 0)) :gitsigns_head)
      (. (. vim.b (or bufnr 0)) :gitsigns_status_dict)))
(fn M.git_changed [bufnr]
  (when (= (type bufnr) :table) (set-forcibly! bufnr bufnr.bufnr))
  (local git-status (. (. vim.b (or bufnr 0)) :gitsigns_status_dict))
  (and git-status (> (+ (+ (or git-status.added 0) (or git-status.removed 0))
                        (or git-status.changed 0)) 0)))
(fn M.file_modified [bufnr]
  (when (= (type bufnr) :table) (set-forcibly! bufnr bufnr.bufnr))
  (. (. vim.bo (or bufnr 0)) :modified))
(fn M.file_read_only [bufnr]
  (when (= (type bufnr) :table) (set-forcibly! bufnr bufnr.bufnr))
  (local buffer (. vim.bo (or bufnr 0)))
  (or (not buffer.modifiable) buffer.readonly))
(fn M.has_diagnostics [bufnr]
  (when (= (type bufnr) :table) (set-forcibly! bufnr bufnr.bufnr))
  (and (> vim.g.diagnostics_mode 0) (> (length (vim.diagnostic.get (or bufnr 0)))
                                       0)))
(fn M.has_filetype [bufnr]
  (when (= (type bufnr) :table) (set-forcibly! bufnr bufnr.bufnr))
  (and (. (. vim.bo (or bufnr 0)) :filetype)
       (not= (. (. vim.bo (or bufnr 0)) :filetype) "")))
(fn M.aerial_available [] (. package.loaded :aerial))
(fn M.lsp_attached [bufnr]
  (when (= (type bufnr) :table) (set-forcibly! bufnr bufnr.bufnr))
  (and (. package.loaded :utils.astro.lsp)
       (not= (next (vim.lsp.get_active_clients {:bufnr (or bufnr 0)})) nil)))
(fn M.treesitter_available [bufnr]
  (when (not (. package.loaded :nvim-treesitter)) (lua "return false"))
  (when (= (type bufnr) :table) (set-forcibly! bufnr bufnr.bufnr))
  (local parsers (require :nvim-treesitter.parsers))
  (parsers.has_parser (parsers.get_buf_lang (or bufnr
                                                (vim.api.nvim_get_current_buf)))))
(fn M.foldcolumn_enabled [] (not= (vim.opt.foldcolumn:get) :0))
(fn M.numbercolumn_enabled []
  (or (vim.opt.number:get) (vim.opt.relativenumber:get)))
(fn M.signcolumn_enabled [] (not= (vim.opt.signcolumn:get) :no))
M
