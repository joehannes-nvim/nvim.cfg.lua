; ### AstroNvim Buffer Utilities
;
; Buffer management related utility functions
;
; This module can be loaded with `local buffer_utils = require "astronvim.utils.buffer"`
;
; @module astronvim.utils.buffer
; @copyright 2022
; @license GNU General Public License v3.0

(local M {})
(local utils (require :utils.astro))
(set (M.current_buf M.last_buf) (values nil nil))
(set M.sessions {:autosave {:cwd true :last true}
                 :ignore {:buftypes {}
                          :dirs {}
                          :filetypes [:gitcommit :gitrebase]}})
(fn M.is_valid [bufnr]
  (when (not bufnr) (set-forcibly! bufnr 0))
  (and (vim.api.nvim_buf_is_valid bufnr) (. (. vim.bo bufnr) :buflisted)))
(fn M.is_restorable [bufnr]
  (when (or (not (M.is_valid bufnr))
            (not= (vim.api.nvim_get_option_value :bufhidden {:buf bufnr}) ""))
    (lua "return false"))
  (local buftype (vim.api.nvim_get_option_value :buftype {:buf bufnr}))
  (when (= buftype "")
    (when (not (vim.api.nvim_get_option_value :buflisted {:buf bufnr}))
      (lua "return false"))
    (when (= (vim.api.nvim_buf_get_name bufnr) "") (lua "return false")))
  (when (or (vim.tbl_contains M.sessions.ignore.filetypes
                              (vim.api.nvim_get_option_value :filetype
                                                             {:buf bufnr}))
            (vim.tbl_contains M.sessions.ignore.buftypes
                              (vim.api.nvim_get_option_value :buftype
                                                             {:buf bufnr})))
    (lua "return false"))
  true)
(fn M.is_valid_session []
  (let [cwd (vim.fn.getcwd)]
    (each [_ dir (ipairs M.sessions.ignore.dirs)]
      (when (= (vim.fn.expand dir) cwd) (lua "return false")))
    (each [_ bufnr (ipairs (vim.api.nvim_list_bufs))]
      (when (M.is_restorable bufnr) (lua "return true")))
    false))
(fn M.move [n]
  (when (= n 0) (lua "return "))
  (local bufs vim.t.bufs)
  (each [i bufnr (ipairs bufs)]
    (when (= bufnr (vim.api.nvim_get_current_buf))
      (for [_ 0 (- (% n (length bufs)) 1)]
        (var new-i (+ i 1))
        (if (= i (length bufs))
            (do
              (set new-i 1) (local val (. bufs i))
              (table.remove bufs i)
              (table.insert bufs new-i val))
            (let [tmp (. bufs i)]
              (tset bufs i (. bufs new-i))
              (tset bufs new-i tmp)))
        (set-forcibly! i new-i))
      (lua :break)))
  (set vim.t.bufs bufs)
  (utils.event :BufsUpdated)
  (vim.cmd.redrawtabline))
(fn M.nav [n]
  (let [current (vim.api.nvim_get_current_buf)]
    (each [i v (ipairs vim.t.bufs)]
      (when (= current v)
        (vim.cmd.b (. vim.t.bufs (+ (% (- (+ i n) 1) (length vim.t.bufs)) 1)))
        (lua :break)))))
(fn M.nav_to [tabnr]
  (if (or (> tabnr (length vim.t.bufs)) (< tabnr 1))
      (utils.notify (: "No tab #%d" :format tabnr) vim.log.levels.WARN)
      (vim.cmd.b (. vim.t.bufs tabnr))))
(fn M.prev []
  (if (= (vim.fn.bufnr) M.current_buf)
      (if M.last_buf (vim.cmd.b M.last_buf)
          (utils.notify "No previous buffer found" vim.log.levels.WARN))
      (utils.notify "Must be in a main editor window to switch the window buffer"
                    vim.log.levels.ERROR)))
(fn M.close [bufnr force]
  (when (or (not bufnr) (= bufnr 0))
    (set-forcibly! bufnr (vim.api.nvim_get_current_buf)))
  (if (and (and (utils.is_available :mini.bufremove) (M.is_valid bufnr))
           (> (length vim.t.bufs) 1))
      (do
        (when (and (not force)
                   (vim.api.nvim_get_option_value :modified {:buf bufnr}))
          (var bufname (vim.fn.expand "%"))
          (local empty (= bufname ""))
          (when empty (set bufname :Untitled))
          (local confirm
                 (vim.fn.confirm (: "Save changes to \"%s\"?" :format bufname)
                                 "&Yes\n&No\n&Cancel" 1 :Question))
          (if (= confirm 1) (do
                              (when empty (lua "return "))
                              (vim.cmd.write))
              (= confirm 2) (set-forcibly! force true)
              (lua "return ")))
        ((. (require :mini.bufremove) :delete) bufnr force))
      (let [buftype (vim.api.nvim_get_option_value :buftype {:buf bufnr})]
        (vim.cmd (: "silent! %s %d" :format
                    (or (and (or force (= buftype :terminal)) :bdelete!)
                        "confirm bdelete") bufnr)))))
(fn M.close_all [keep-current force]
  (when (= keep-current nil) (set-forcibly! keep-current false))
  (local current (vim.api.nvim_get_current_buf))
  (each [_ bufnr (ipairs vim.t.bufs)]
    (when (or (not keep-current) (not= bufnr current)) (M.close bufnr force))))
(fn M.close_left [force]
  (let [current (vim.api.nvim_get_current_buf)]
    (each [_ bufnr (ipairs vim.t.bufs)] (when (= bufnr current) (lua :break))
      (M.close bufnr force))))
(fn M.close_right [force]
  (let [current (vim.api.nvim_get_current_buf)]
    (var after-current false)
    (each [_ bufnr (ipairs vim.t.bufs)]
      (when after-current (M.close bufnr force))
      (when (= bufnr current) (set after-current true)))))
(fn M.sort [compare-func skip-autocmd]
  (when (= (type compare-func) :string)
    (set-forcibly! compare-func (. M.comparator compare-func)))
  (when (= (type compare-func) :function) (local bufs vim.t.bufs)
    (table.sort bufs compare-func)
    (set vim.t.bufs bufs)
    (when (not skip-autocmd) (utils.event :BufsUpdated))
    (vim.cmd.redrawtabline)
    (lua "return true"))
  false)
(fn M.close_tab [tabpage]
  (when (> (length (vim.api.nvim_list_tabpages)) 1)
    (set-forcibly! tabpage (or tabpage (vim.api.nvim_get_current_tabpage)))
    (tset (. vim.t tabpage) :bufs nil)
    (utils.event :BufsUpdated)
    (vim.cmd.tabclose (vim.api.nvim_tabpage_get_number tabpage))))
(set M.comparator {})
(local fnamemodify vim.fn.fnamemodify)
(fn bufinfo [bufnr] (. (vim.fn.getbufinfo bufnr) 1))
(fn unique-path [bufnr]
  (.. (((. (require :utils.astro.status.provider) :unique_path)) {: bufnr})
      (fnamemodify (. (bufinfo bufnr) :name) ":t")))
(fn M.comparator.bufnr [bufnr-a bufnr-b] (< bufnr-a bufnr-b))
(fn M.comparator.extension [bufnr-a bufnr-b]
  (< (fnamemodify (. (bufinfo bufnr-a) :name) ":e")
     (fnamemodify (. (bufinfo bufnr-b) :name) ":e")))
(fn M.comparator.full_path [bufnr-a bufnr-b]
  (< (fnamemodify (. (bufinfo bufnr-a) :name) ":p")
     (fnamemodify (. (bufinfo bufnr-b) :name) ":p")))
(fn M.comparator.unique_path [bufnr-a bufnr-b]
  (< (unique-path bufnr-a) (unique-path bufnr-b)))
(fn M.comparator.modified [bufnr-a bufnr-b]
  (> (. (bufinfo bufnr-a) :lastused) (. (bufinfo bufnr-b) :lastused)))
M
