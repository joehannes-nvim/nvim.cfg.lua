; ### AstroNvim Status Providers
;
; Statusline related provider functions for building statusline components
;
; This module can be loaded with `local provider = require "utils.astro.status.provider"`
;
; @module utils.astro.status.provider
; @copyright 2023
; @license GNU General Public License v3.0

(local M {})
(local condition (require :utils.astro.status.condition))
(local env (require :utils.astro.status.env))
(local status-utils (require :utils.astro.status.utils))
(local utils (require :utils.astro))
(local extend-tbl utils.extend_tbl)
(local get-icon utils.get_icon)
(local luv (or vim.uv vim.loop))
(fn M.fill []
  "%=")
(fn M.signcolumn [opts]
  (set-forcibly! opts (extend-tbl {:escape false} opts))
  (status-utils.stylize "%s" opts))
(fn M.numbercolumn [opts]
  (set-forcibly! opts (extend-tbl {:culright true
                                   :escape false
                                   :thousands false}
                                  opts))
  (fn [self]
    (let [(lnum rnum virtnum) (values vim.v.lnum vim.v.relnum vim.v.virtnum)
          (num relnum) (values (vim.opt.number:get)
                               (vim.opt.relativenumber:get))
          signs (and (: (vim.opt.signcolumn:get) :find :nu)
                     (. (. (vim.fn.sign_getplaced (or self.bufnr
                                                      (vim.api.nvim_get_current_buf))
                                                  {:group "*" : lnum})
                           1) :signs))]
      (var str nil)
      (if (not= virtnum 0) (set str "%=") (and signs (> (length signs) 0))
          (let [sign (. (vim.fn.sign_getdefined (. (. signs 1) :name)) 1)]
            (set str (.. "%=%#" sign.texthl "#" sign.text "%*")))
          (and (not num) (not relnum)) (set str "%=")
          (do
            (var cur (or (and relnum
                              (or (and (> rnum 0) rnum) (or (and num lnum) 0)))
                         lnum))
            (when (and opts.thousands (> cur 999))
              (set cur (: (: (: (string.reverse cur) :gsub "%d%d%d"
                                (.. "%1" opts.thousands))
                             :reverse) :gsub
                          (.. "^%" opts.thousands) "")))
            (set str (or (and (and (and (= rnum 0) (not opts.culright)) relnum)
                              (.. cur "%="))
                         (.. "%=" cur)))))
      (status-utils.stylize str opts))))
(fn M.foldcolumn [opts]
  (set-forcibly! opts (extend-tbl {:escape false} opts))
  (local ffi (require :utils.astro.ffi))
  (local fillchars (vim.opt.fillchars:get))
  (local foldopen (or fillchars.foldopen (get-icon :FoldOpened)))
  (local foldclosed (or fillchars.foldclose (get-icon :FoldClosed)))
  (local foldsep (or fillchars.foldsep (get-icon :FoldSeparator)))
  (fn []
    (let [wp (ffi.C.find_window_by_handle 0 (ffi.new :Error))
          width (ffi.C.compute_foldcolumn wp 0)
          foldinfo (or (and (> width 0) (ffi.C.fold_info wp vim.v.lnum))
                       {:level 0 :lines 0 :llevel 0 :start 0})]
      (var str "")
      (when (not= width 0)
        (set str (or (and (> vim.v.relnum 0) "%#FoldColumn#")
                     "%#CursorLineFold#"))
        (if (= foldinfo.level 0) (set str (.. str (: " " :rep width)))
            (let [closed (> foldinfo.lines 0)]
              (var first-level (+ (- (- foldinfo.level width)
                                     (or (and closed 1) 0))
                                  1))
              (when (< first-level 1) (set first-level 1))
              (for [col 1 width]
                (set str (.. str (or (or (or (and (not= vim.v.virtnum 0)
                                                  foldsep)
                                             (and (and closed
                                                       (or (= col
                                                              foldinfo.level)
                                                           (= col width)))
                                                  foldclosed))
                                         (and (and (= foldinfo.start vim.v.lnum)
                                                   (> (+ first-level col)
                                                      foldinfo.llevel))
                                              foldopen))
                                     foldsep)))
                (when (= col foldinfo.level)
                  (set str (.. str (: " " :rep (- width col))))
                  (lua :break))))))
      (status-utils.stylize (.. str "%*") opts))))
(fn M.tabnr []
  (fn [self]
    (or (and (and self self.tabnr) (.. "%" self.tabnr "T " self.tabnr " %T"))
        "")))
(fn M.spell [opts]
  (set-forcibly! opts (extend-tbl {:icon {:kind :Spellcheck}
                                   :show_empty true
                                   :str ""}
                                  opts))
  (fn []
    (status-utils.stylize (or (and vim.wo.spell opts.str) nil) opts)))
(fn M.paste [opts]
  (set-forcibly! opts (extend-tbl {:icon {:kind :Paste}
                                   :show_empty true
                                   :str ""}
                                  opts))
  (var paste vim.opt.paste)
  (when (not= (type paste) :boolean) (set paste (paste:get)))
  (fn []
    (status-utils.stylize (or (and paste opts.str) nil) opts)))
(fn M.macro_recording [opts]
  (set-forcibly! opts (extend-tbl {:prefix "@"} opts))
  (fn []
    (var register (vim.fn.reg_recording))
    (when (not= register "") (set register (.. opts.prefix register)))
    (status-utils.stylize register opts)))
(fn M.showcmd [opts]
  (set-forcibly! opts (extend-tbl {:escape false :maxwid 5 :minwid 0} opts))
  (status-utils.stylize (: "%%%d.%d(%%S%%)" :format opts.minwid opts.maxwid)
                        opts))
(fn M.search_count [opts]
  (let [search-func (or (and (vim.tbl_isempty (or opts {}))
                             (fn [] (vim.fn.searchcount)))
                        (fn [] (vim.fn.searchcount opts)))]
    (fn []
      (let [(search-ok search) (pcall search-func)]
        (when (and (and search-ok (= (type search) :table)) search.total)
          (status-utils.stylize (string.format "%s%d/%s%d"
                                               (or (and (> search.current
                                                           search.maxcount)
                                                        ">")
                                                   "")
                                               (math.min search.current
                                                         search.maxcount)
                                               (or (and (= search.incomplete 2)
                                                        ">")
                                                   "")
                                               (math.min search.total
                                                         search.maxcount))
                                opts))))))
(fn M.mode_text [opts]
  (let [max-length (math.max (unpack (vim.tbl_map (fn [str] (length (. str 1)))
                                                  (vim.tbl_values env.modes))))]
    (fn []
      (var text (. (. env.modes (vim.fn.mode)) 1))
      (when (and opts opts.pad_text)
        (local padding (- max-length (length text)))
        (if (= opts.pad_text :right)
            (set text (.. (string.rep " " padding) text))
            (= opts.pad_text :left)
            (set text (.. text (string.rep " " padding)))
            (= opts.pad_text :center)
            (set text
                 (.. (string.rep " " (math.floor (/ padding 2))) text
                     (string.rep " " (math.ceil (/ padding 2)))))))
      (status-utils.stylize text opts))))
(fn M.percentage [opts]
  (set-forcibly! opts (extend-tbl {:edge_text true
                                   :escape false
                                   :fixed_width true}
                                  opts))
  (fn []
    (var text (.. "%" (or (and opts.fixed_width (or (and opts.edge_text :2) :3))
                          "") "p%%"))
    (when opts.edge_text
      (local current-line (vim.fn.line "."))
      (if (= current-line 1) (set text :Top)
          (= current-line (vim.fn.line "$")) (set text :Bot)))
    (status-utils.stylize text opts)))
(fn M.ruler [opts]
  (set-forcibly! opts (extend-tbl {:pad_ruler {:char 2 :line 3}} opts))
  (local padding-str (string.format "%%%dd:%%-%dd" opts.pad_ruler.line
                                    opts.pad_ruler.char))
  (fn []
    (let [line (vim.fn.line ".")
          char (vim.fn.virtcol ".")]
      (status-utils.stylize (string.format padding-str line char) opts))))
(fn M.scrollbar [opts]
  (let [sbar ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"]]
    (fn []
      (let [curr-line (. (vim.api.nvim_win_get_cursor 0) 1)
            lines (vim.api.nvim_buf_line_count 0)
            i (+ (math.floor (* (/ (- curr-line 1) lines) (length sbar))) 1)]
        (when (. sbar i)
          (status-utils.stylize (string.rep (. sbar i) 2) opts))))))
(fn M.close_button [opts]
  (set-forcibly! opts (extend-tbl {:kind :BufferClose} opts))
  (status-utils.stylize (get-icon opts.kind) opts))
(fn M.filetype [opts]
  (fn [self]
    (let [buffer (. vim.bo (or (and self self.bufnr) 0))]
      (status-utils.stylize (string.lower buffer.filetype) opts))))
(fn M.filename [opts]
  (set-forcibly! opts (extend-tbl {:fallback :Untitled
                                   :fname (fn [nr]
                                            (vim.api.nvim_buf_get_name nr))
                                   :modify ":t"}
                                  opts))
  (fn [self]
    (let [path (opts.fname (or (and self self.bufnr) 0))
          filename (vim.fn.fnamemodify path opts.modify)]
      (status-utils.stylize (or (and (= path "") opts.fallback) filename) opts))))
(fn M.file_encoding [opts]
  (fn [self]
    (let [buf-enc (. (. vim.bo (or (and self self.bufnr) 0)) :fenc)]
      (status-utils.stylize (string.upper (or (and (not= buf-enc "") buf-enc)
                                              vim.o.enc))
                            opts))))
(fn M.file_format [opts]
  (fn [self]
    (let [buf-format (. (. vim.bo (or (and self self.bufnr) 0)) :fileformat)]
      (status-utils.stylize (string.upper (or (and (not= buf-format "")
                                                   buf-format)
                                              vim.o.fileformat))
                            opts))))
(fn M.unique_path [opts]
  (set-forcibly! opts (extend-tbl {:buf_name (fn [bufnr]
                                               (vim.fn.fnamemodify (vim.api.nvim_buf_get_name bufnr)
                                                                   ":t"))
                                   :bufnr 0
                                   :max_length 16}
                                  opts))

  (fn path-parts [bufnr]
    (let [parts {}]
      (each [___match___ (: (.. (vim.api.nvim_buf_get_name bufnr) "/") :gmatch
                            (.. "(.-)" "/"))]
        (table.insert parts ___match___))
      parts))

  (fn [self]
    (set opts.bufnr (or (and self self.bufnr) opts.bufnr))
    (local name (opts.buf_name opts.bufnr))
    (var unique-path "")
    (var current nil)
    (each [_ value (ipairs (or vim.t.bufs {}))]
      (when (and (= name (opts.buf_name value)) (not= value opts.bufnr))
        (when (not current) (set current (path-parts opts.bufnr)))
        (local other (path-parts value))
        (for [i (- (length current) 1) 1 (- 1)]
          (when (not= (. current i) (. other i))
            (set unique-path (.. (. current i) "/"))
            (lua :break)))))
    (status-utils.stylize (or (and (and (> opts.max_length 0)
                                        (> (length unique-path) opts.max_length))
                                   (.. (string.sub unique-path 1
                                                   (- opts.max_length 2))
                                       (get-icon :Ellipsis) "/"))
                              unique-path) opts)))
(fn M.file_modified [opts]
  (set-forcibly! opts (extend-tbl {:icon {:kind :FileModified}
                                   :show_empty true
                                   :str ""}
                                  opts))
  (fn [self]
    (status-utils.stylize (or (and (condition.file_modified (. (or self {})
                                                               :bufnr))
                                   opts.str) nil)
                          opts)))
(fn M.file_read_only [opts]
  (set-forcibly! opts (extend-tbl {:icon {:kind :FileReadOnly}
                                   :show_empty true
                                   :str ""}
                                  opts))
  (fn [self]
    (status-utils.stylize (or (and (condition.file_read_only (. (or self {})
                                                                :bufnr))
                                   opts.str) nil)
                          opts)))
(fn M.file_icon [opts]
  (fn [self]
    (let [(devicons-avail devicons) (pcall require :nvim-web-devicons)]
      (when (not devicons-avail) (lua "return \"\""))
      (local bufnr (or (and self self.bufnr) 0))
      (var (ft-icon _)
           (devicons.get_icon (vim.fn.fnamemodify (vim.api.nvim_buf_get_name bufnr)
                                                  ":t")))
      (when (not ft-icon)
        (set (ft-icon _)
             (devicons.get_icon_by_filetype (. (. vim.bo bufnr) :filetype)
                                            {:default true})))
      (status-utils.stylize ft-icon opts))))
(fn M.git_branch [opts]
  (fn [self]
    (status-utils.stylize (or (. (. vim.b (or (and self self.bufnr) 0))
                                 :gitsigns_head)
                              "") opts)))
(fn M.git_diff [opts]
  (when (or (not opts) (not opts.type)) (lua "return "))
  (fn [self]
    (let [status (. (. vim.b (or (and self self.bufnr) 0))
                    :gitsigns_status_dict)]
      (status-utils.stylize (or (and (and (and status (. status opts.type))
                                          (> (. status opts.type) 0))
                                     (tostring (. status opts.type)))
                                "") opts))))
(fn M.diagnostics [opts]
  (when (or (not opts) (not opts.severity)) (lua "return "))
  (fn [self]
    (let [bufnr (or (and self self.bufnr) 0)
          count (length (vim.diagnostic.get bufnr
                                            (and opts.severity
                                                 {:severity (. vim.diagnostic.severity
                                                               opts.severity)})))]
      (status-utils.stylize (or (and (not= count 0) (tostring count)) "") opts))))
(fn M.lsp_progress [opts]
  (let [spinner (or (utils.get_spinner :LSPLoading 1) [""])]
    (fn []
      (let [(_ Lsp) (next _G.my.astro.lsp.progress)]
        (status-utils.stylize (and Lsp
                                   (.. (. spinner
                                          (+ (% (math.floor (/ (luv.hrtime)
                                                               120000000.0))
                                                (length spinner))
                                             1))
                                       (table.concat [(or Lsp.title "")
                                                      (or Lsp.message "")
                                                      (or (and Lsp.percentage
                                                               (.. "("
                                                                   Lsp.percentage
                                                                   "%)"))
                                                          "")]
                                                     " ")))
                              opts)))))
(fn M.lsp_client_names [opts]
  (set-forcibly! opts (extend-tbl {:expand_null_ls true :truncate 0.25} opts))
  (fn [self]
    (let [buf-client-names {}]
      (each [_ client (pairs (vim.lsp.get_active_clients {:bufnr (or (and self
                                                                          self.bufnr)
                                                                     0)}))]
        (if (and (= client.name :null-ls) opts.expand_null_ls)
            (let [null-ls-sources {}]
              (each [_ type (ipairs [:FORMATTING :DIAGNOSTICS])]
                (each [_ source (ipairs (status-utils.null_ls_sources vim.bo.filetype
                                                                      type))]
                  (tset null-ls-sources source true)))
              (vim.list_extend buf-client-names (vim.tbl_keys null-ls-sources)))
            (table.insert buf-client-names client.name)))
      (var str (table.concat buf-client-names ", "))
      (when (= (type opts.truncate) :number)
        (local max-width (math.floor (* (status-utils.width) opts.truncate)))
        (when (> (length str) max-width)
          (set str (.. (string.sub str 0 max-width) "…"))))
      (status-utils.stylize str opts))))
(fn M.treesitter_status [opts]
  (fn []
    (status-utils.stylize (or (and ((. (require :nvim-treesitter.parser)
                                       :has_parser))
                                   :TS) "") opts)))
(fn M.str [opts]
  (set-forcibly! opts (extend-tbl {:str " "} opts))
  (status-utils.stylize opts.str opts))
M
