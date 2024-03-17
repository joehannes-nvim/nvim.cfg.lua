; ### AstroNvim Status Initializers
;
; Statusline related init functions for building dynamic statusline components
;
; This module can be loaded with `local init = require "utils.astro.status.init"`
;
; @module utils.astro.status.init
; @copyright 2023
; @license GNU General Public License v3.0

(local M {})
(local env (require :utils.astro.status.env))
(local provider (require :utils.astro.status.provider))
(local status-utils (require :utils.astro.status.utils))
(local utils (require :utils.astro))
(local extend-tbl utils.extend_tbl)
(fn M.breadcrumbs [opts]
  (set-forcibly! opts (extend-tbl {:icon {:enabled true
                                          :hl env.icon_highlights.breadcrumbs}
                                   :max_depth 5
                                   :padding {:left 0 :right 0}
                                   :separator (or env.separators.breadcrumbs
                                                  "  ")}
                                  opts))
  (fn [self]
    (let [data (or ((. (require :aerial) :get_location) true) {})
          children {}]
      (when (and opts.prefix (not (vim.tbl_isempty data)))
        (table.insert children
                      {:provider (or (and (= opts.prefix true) opts.separator)
                                     opts.prefix)}))
      (var start-idx 0)
      (when (and opts.max_depth (> opts.max_depth 0))
        (set start-idx (- (length data) opts.max_depth))
        (when (> start-idx 0)
          (table.insert children
                        {:provider (.. ((. (require :utils.astro) :get_icon) :Ellipsis)
                                       opts.separator)})))
      (each [i d (ipairs data)]
        (when (> i start-idx)
          (local child
                 {1 {:provider (: (string.gsub d.name "%%" "%%%%") :gsub
                                  "%s*->%s*" "")}
                  :on_click {:callback (fn [_ minwid]
                                         (local (lnum col winnr)
                                                (status-utils.decode_pos minwid))
                                         (vim.api.nvim_win_set_cursor (vim.fn.win_getid winnr)
                                                                      [lnum
                                                                       col]))
                             :minwid (status-utils.encode_pos d.lnum d.col
                                                              self.winnr)
                             :name :heirline_breadcrumbs}})
          (when opts.icon.enabled
            (var hl opts.icon.hl)
            (when (= (type hl) :function) (set hl (hl self)))
            (local hlgroup (string.format "Aerial%sIcon" d.kind))
            (table.insert child 1
                          {:hl (or (and (and hl (= (vim.fn.hlexists hlgroup) 1))
                                        hlgroup)
                                   nil)
                           :provider (string.format "%s " d.icon)}))
          (when (and (> (length data) 1) (< i (length data)))
            (table.insert child {:provider opts.separator}))
          (table.insert children child)))
      (when (> opts.padding.left 0)
        (table.insert children 1
                      {:provider (status-utils.pad_string " "
                                                          {:left (- opts.padding.left
                                                                    1)})}))
      (when (> opts.padding.right 0)
        (table.insert children
                      {:provider (status-utils.pad_string " "
                                                          {:right (- opts.padding.right
                                                                     1)})}))
      (tset self 1 (self:new children 1)))))
(fn M.separated_path [opts]
  (set-forcibly! opts (extend-tbl {:max_depth 3
                                   :padding {:left 0 :right 0}
                                   :path_func (provider.unique_path)
                                   :separator (or env.separators.path "  ")
                                   :suffix true}
                                  opts))
  (when (= opts.suffix true) (set opts.suffix opts.separator))
  (fn [self]
    (var path (opts.path_func self))
    (when (= path ".") (set path ""))
    (local data (vim.fn.split path "/"))
    (local children {})
    (when (and opts.prefix (not (vim.tbl_isempty data)))
      (table.insert children
                    {:provider (or (and (= opts.prefix true) opts.separator)
                                   opts.prefix)}))
    (var start-idx 0)
    (when (and opts.max_depth (> opts.max_depth 0))
      (set start-idx (- (length data) opts.max_depth))
      (when (> start-idx 0)
        (table.insert children
                      {:provider (.. ((. (require :utils.astro) :get_icon) :Ellipsis)
                                     opts.separator)})))
    (each [i d (ipairs data)]
      (when (> i start-idx)
        (local child [{:provider d}])
        (local separator (or (and (< i (length data)) opts.separator)
                             opts.suffix))
        (when separator (table.insert child {:provider separator}))
        (table.insert children child)))
    (when (> opts.padding.left 0)
      (table.insert children 1
                    {:provider (status-utils.pad_string " "
                                                        {:left (- opts.padding.left
                                                                  1)})}))
    (when (> opts.padding.right 0)
      (table.insert children
                    {:provider (status-utils.pad_string " "
                                                        {:right (- opts.padding.right
                                                                   1)})}))
    (tset self 1 (self:new children 1))))
(fn M.update_events [opts]
  (fn [self]
    (when (not (rawget self :once))
      (fn clear-cache [] (set self._win_cache nil))

      (each [_ event (ipairs opts)]
        (local event-opts {:callback clear-cache})
        (when (= (type event) :table) (set event-opts.pattern event.pattern)
          (set event-opts.callback (or event.callback clear-cache))
          (set event.pattern nil)
          (set event.callback nil))
        (vim.api.nvim_create_autocmd event event-opts))
      (set self.once true))))
M
