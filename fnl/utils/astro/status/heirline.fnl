; ### AstroNvim Status Heirline Extensions
;
; Statusline related heirline specific extensions
;
; This module can be loaded with `local astro_heirline = require "utils.astro.status.heirline"`
;
; @module utils.astro.status.heirline
; @copyright 2023
; @license GNU General Public License v3.0

(local M {})
(local hl (require :utils.astro.status.hl))
(local provider (require :utils.astro.status.provider))
(local status-utils (require :utils.astro.status.utils))
(local utils (require :utils.astro))
(local buffer-utils (require :utils.astro.buffer))
(local get-icon utils.get_icon)
(fn M.tab_type [self prefix] (var tab-type "")
  (if self.is_active (set tab-type :_active)
      self.is_visible (set tab-type :_visible))
  (.. (or prefix :buffer) tab-type))
(set M.make_buflist
     (fn [component]
       (let [overflow-hl (hl.get_attributes :buffer_overflow true)]
         ((. (require :heirline.utils) :make_buflist) (status-utils.surround :tab
                                                                             (fn [self]
                                                                               {:left :tabline_bg
                                                                                :main (.. (M.tab_type self)
                                                                                          :_bg)
                                                                                :right :tabline_bg})
                                                                             {1 {:condition (fn [self]
                                                                                              self._show_picker)
                                                                                 :hl (hl.get_attributes :buffer_picker)
                                                                                 :init (fn [self]
                                                                                         (when (not (and self.label
                                                                                                         (. self._picker_labels
                                                                                                            self.label)))
                                                                                           (local bufname
                                                                                                  ((provider.filename) self))
                                                                                           (var label
                                                                                                (bufname:sub 1
                                                                                                             1))
                                                                                           (var i
                                                                                                2)
                                                                                           (while (and (not= label
                                                                                                             " ")
                                                                                                       (. self._picker_labels
                                                                                                          label))
                                                                                             (when (> i
                                                                                                      (length bufname))
                                                                                               (lua :break))
                                                                                             (set label
                                                                                                  (bufname:sub i
                                                                                                               i))
                                                                                             (set i
                                                                                                  (+ i
                                                                                                     1)))
                                                                                           (tset self._picker_labels
                                                                                                 label
                                                                                                 self.bufnr)
                                                                                           (set self.label
                                                                                                label)))
                                                                                 :provider (fn [self]
                                                                                             (provider.str {:padding {:left 1
                                                                                                                      :right 1}
                                                                                                            :str self.label}))
                                                                                 :update false}
                                                                              2 component
                                                                              :init (fn [self]
                                                                                      (set self.tab_type
                                                                                           (M.tab_type self)))
                                                                              :on_click {:callback (fn [_
                                                                                                        minwid]
                                                                                                     (vim.api.nvim_win_set_buf 0
                                                                                                                               minwid))
                                                                                         :minwid (fn [self]
                                                                                                   self.bufnr)
                                                                                         :name :heirline_tabline_buffer_callback}}
                                                                             (fn [self]
                                                                               (buffer-utils.is_valid self.bufnr)))
                                                      {:hl overflow-hl
                                                       :provider (.. (get-icon :ArrowLeft)
                                                                     " ")}
                                                      {:hl overflow-hl
                                                       :provider (.. (get-icon :ArrowRight)
                                                                     " ")}
                                                      (fn [] (or vim.t.bufs {}))
                                                      false))))
(fn M.make_tablist [...]
  ((. (require :heirline.utils) :make_tablist) ...))
(fn M.buffer_picker [callback]
  (let [tabline (. (require :heirline) :tabline)
        prev-showtabline (vim.opt.showtabline:get)]
    (when (not= prev-showtabline 2) (set vim.opt.showtabline 2))
    (vim.cmd.redrawtabline)
    (local buflist (and (and tabline tabline._buflist) (. tabline._buflist 1)))
    (when buflist (set buflist._picker_labels {})
      (set buflist._show_picker true)
      (vim.cmd.redrawtabline)
      (local char (vim.fn.getcharstr))
      (local bufnr (. buflist._picker_labels char))
      (when bufnr (callback bufnr))
      (set buflist._show_picker false))
    (when (not= prev-showtabline 2) (set vim.opt.showtabline prev-showtabline))
    (vim.cmd.redrawtabline)))
M
